---
layout: project
type: project
status: posted
published: true
redirect_from:
  - /projects/current/nvidia-blackwell-mtp-mitigation/
  - /projects/future/nvidia-blackwell-mtp-mitigation/
  - /projects/past/nvidia-blackwell-mtp-mitigation/
  - /projects/current/2026-09-17-nvidia-blackwell-mtp-mitigation/
  - /projects/future/2026-09-17-nvidia-blackwell-mtp-mitigation/
  - /projects/past/2026-09-17-nvidia-blackwell-mtp-mitigation/
title: NVIDIA Broke All Blackwells But I Have A Temporary Fix
description: I threw two-hundred-million tokens at this problem and found a patch (50% speed-up) until NVIDIA fixes their broken blackwell drivers.
image: /projects/2026-09-17-nvidia-blackwell-mtp-mitigation/blackwell-broken.fw.png
imageAlt: Abstract dark image of shattered black glass
pubdate: 2026-09-17
lastUpdated: 2026-09-18
---

NOTE: This is experimental. Don't rely on this in production. Please provide feedback if you have any issues or find a better approach.

NVIDIA broke a critical feature on all their current-generation Blackwell GPUs, including those on my Jetson Thors. I noticed that despite the fact MTP was enabled, I was seeing surprisingly low inference speeds on models like qwen3.8:27b and qwen3.6:35b-a3b. Blackwells are already pretty fast, so it would be easy to mistake broken speculative decoding for normal and expected Blackwell speeds. They should be working much faster than they currently are.

Both of these models include a feature called speculative decoding. The qwen implementation of speculative decoding is called mtp for multi-token prediction. A LLM has to do all of its math for every token it predicts. But sometimes there are times where it's very obvious what the next token or next few tokens are going to be. Speculative decoding pairs the full-size model with a smaller model which creates drafts of what it thinks the model is about to say. The big model can then select from those drafts instead of doing all the work of typing out each of the characters. I was excited to try these models on blackwell because I knew this feature should enable a speed-ups of some hundreds of percent.

But it didn't. At first I chalked it up to Blackwell being just as overpromised as the rest of NVIDIA's products always are. But the more I saw the low tps numbers, the more it bugged me. At some point, I asked an agent to deep research if there was some configuration problem or missing piece that was stopping speculative decoding from working. 

The agent initially told me speculative decoding was definitely enabled and working, because there was a percent value for its acceptance rate. This is the rate of how often the model accepts a draft in order to skip doing all the work on a bunch of tokens in a row. 

"But wait," the agent said, "the acceptance rate is 36%. That is extremely unusual. It should be close to 100%." A bit more research and the agent found countless errors and issues reported with inference frameworks across the web. It seems there is a problem with the current NVIDIA Blackwell drivers. Some bug in the current NVIDIA kernel drivers causes the drafts to become progressively more insane the longer they get.

I knew this problem would eventually be patched by the community until NVIDIA someday decides to fix it. We waited almost a year after they bricked all the Jetson Nano GPUs before NVIDIA decided to fix them. I also knew that even a rack of Thors would take too long to find the answer. So I pulled Cerebras in for the assist.

On Cerebras, qwen3.8:27b runs at 1,500 tokens per second. I asked it to find a mitigation for this issue that would give me the maximum tps until NVIDIA patches the broken drivers.

It decided to construct a search matrix across the hyperparameters related to speculative decoding. Then it built a benchmark harness and tested it across the permutations in all five of the dimensions it came up with.  In the end, it used just over **200 million tokens** to build the matrix, build the test harness, and test all the permutations to find the best possible mitigation.

Before the mitigation, the Thors could get about four million tokens per day on qwen3.8:27b. After the mitigation, they can do six million, a 50% increase in speed.

** The fix is telling the model to guess only one token ahead. **

That's the part that stung, because it sounds like the opposite of what you're turning the knob for. But the reality is that it provides a lot of value while avoiding the bug almost entirely. Eventually, NVIDIA will fix it, but until then, this mitigation gives us a lot of extra speed.

## Where the fault lives

The fault is in NVIDIA's Blackwell CUDA path. The same models, the same build, the same prompts: on a Vulkan backend, MTP acceptance sits around 91–92%. On the Blackwell CUDA path it collapses, and it gets worse the deeper the draft goes. That's the bug the driver has to fix, and no flag will cure it.

Stack under test: NVIDIA Thor (aarch64, compute capability 11.0, 122.9 GiB unified memory), L4T 39.2.1, driver 595.78, CUDA 13.2, llama.cpp build `b10835`, release build with `CMAKE_CUDA_ARCHITECTURES=110`.

## The draft-depth cliff

This is the real lesson, and it's NVIDIA's.

Both of these models have **one** built-in prediction head. When it drafts more than one token, every later guess is built on top of the earlier speculative guesses — speculation about speculation. The matrix swept the draft depth from 1 to 6, and acceptance came apart:

| Draft depth | 27B acceptance | 35B acceptance |
| ---: | ---: | ---: |
| 1 | **71.48%** | **89.26%** |
| 2 | 55.81% | 71.60% |
| 3 | 47.31% | 62.71% |
| 4 | 36.05% | 54.02% |
| 6 | **26.03%** | **46.00%** |

On the 27B, acceptance collapses from **71% down to 26%** as the draft depth climbs. That's what the agent's "progressively more insane" looked like in numbers. The deeper the draft, the more of it is garbage the verifier promptly throws out, and you are paying real time to draft tokens you're about to reject. The 35B starts further ahead and decays on the same curve — bigger model, better first guess, same cliff.

This shapes everything below; it's also why the fix has to be a depth limit, not a retune.

## The numbers that matter most

This is the part I'd actually keep the whole post for.

| Model | MTP draft depth | Acceptance | Generation speed | Change vs non-MTP |
| --- | ---: | ---: | ---: | ---: |
| Qwen3.8:27B | Off | — | **10.45 t/s** | — |
| Qwen3.8:27B | **1** | **71.48%** | **15.22 t/s** | **+45.58%** |
| Qwen3.8:27B | 2 | 55.81% | 14.48 t/s | +38.52% |
| Qwen3.8:27B | 3 | 47.31% | 13.15 t/s | +25.84% |
| Qwen3.8:27B | 4 | 36.05% | 11.34 t/s | +8.51% |
| Qwen3.8:27B | 6 | 26.03% | 8.96 t/s | **−14.28%** |
| Qwen3.6:35B | Off | — | **55.53 t/s** | — |
| Qwen3.6:35B | **1** | **89.26%** | **66.98 t/s** | **+20.60%** |
| Qwen3.6:35B | 2 | 71.60% | 63.63 t/s | +14.59% |
| Qwen3.6:35B | 3 | 62.71% | 61.48 t/s | +10.71% |
| Qwen3.6:35B | 4 | 54.02% | 59.18 t/s | +6.57% |
| Qwen3.6:35B | 6 | 46.00% | 53.68 t/s | −3.34% |

Read that last 27B row again: at depth 6, MTP is **14.28% slower than not running MTP at all**. The "faster" setting made the box slower.

**Before the fix, after the fix**, side by side — same model, same build, same machine:

| Model | Pre-mitigation MTP (default draft depth) | Post-mitigation MTP (draft depth capped at 1) |
| --- | --- | --- |
| 27B | **13.14 t/s** · +31% vs non-MTP · **37.85%** acceptance · 1.13 tokens accepted per verification | **15.22 t/s** · **+45.58%** · **71.48%** · **2.404** per pass |
| 35B | **52.60 t/s** · +4.4% | **66.98 t/s** · **+20.60%** · **89.26%** · **2.124** per pass |

A retained September 11 benchmark window tells the 35B story in absolute terms too: **56.64 t/s → 66.98 t/s (+18.26%)**. That's a different window than the matched-control matrix above, so I keep the two comparisons separate instead of blending the numbers.

How the matrix was run: 16 configurations — two models × MTP depths 1/2/3/4/6, plus a non-MTP control interleaved through each block so drift shows up as drift instead of masquerading as an MTP win. Fixed prompt, temperature 0, seed 1337, 512-token generation limit. Two warmup requests for MTP configs, one for controls, and every number above is the median of five measured requests. After the matrix, the chosen depth and its control were repeated in *reversed order* as a check: the 27B stayed close to the main result; the 35B depth-1 repeat came in at 60.97 t/s against 66.98, and its control repeat was clearly abnormal. The main 35B matrix was internally consistent, and that's what I'm standing on.

Now look at the acceptance columns in that before/after table. The 27B moved from **37.85% to 71.48%**; the 35B from **57.96% to 89.26%**. The pre-fix acceptance figures come from retained production counters and the benchmark window that ran before the config change — separate windows from the matched-control speed matrix above, which is why the speed and acceptance comparisons stay side by side instead of mixed into one number. They tell you *why* the speed table looks the way it does.

Here's the mechanism the speed table hides. Token verification is the clock you pay. Before the fix, the 27B was accepting **1.13 tokens per verification pass**. After it: **2.404** — more than double. The 35B went from about 1.73 to **2.124**. Same verifier, same pass, twice as much of the draft sticking. Before the fix, the speculative bet was mostly losing; after, it's a real edge.

## The actual fix

None of this is a driver update, a recompile, or a wait. It's three settings spelled out explicitly, instead of whatever the default silently chose — and nothing else changes. Context, batch size, threads, all of it stays at the model's own defaults:

```text
--spec-type draft-mtp   # enable the built-in MTP head
--spec-draft-n-max 1    # draft at most one future token
--spec-draft-n-min 1    # ...and never fewer
```

The first flag turns the MTP head on; the last two cap the draft depth at one token. Nothing else in the config is doing the work, and nothing is being traded away — you keep your full 262k context and every other setting you already had.

### In llama.cpp (direct llama-server)

The whole command. Only the three `spec` flags are doing the mitigating:

```bash
llama-server \
  -m MODEL.gguf \
  -ngl 99 \
  --spec-type draft-mtp \   # mitigation (1/3): enable the built-in MTP head
  --spec-draft-n-max 1 \    # mitigation (2/3): draft at most one future token
  --spec-draft-n-min 1 \    # mitigation (3/3): and never fewer
  --metrics                 # optional: exposes the acceptance counters the notes below use
```

If anything you'd expect is missing — like a `--ctx-size` — that's deliberate. Context stays at qwen3.8:27b's full 262,144-token window, and the fix works exactly the same at full context. Batch and ubatch stay at llama.cpp's defaults (2048/512), threads auto-detect, and the K/V cache stays at the model's f16 default; none of them interact with the mitigation, so they stay exactly as they would have if you'd never read this post. `-ngl 99` only tells the server to offload the whole model to the GPU, which you're already doing, and `--metrics` is the switch the notes below use to verify the acceptance rate.

Notes from actually running it:

- Pull an MTP-capable model — the Ollama `qwen3.8:27b-mtp-q4_K_M` and `qwen3.6:35b-a3b-mtp-q4_K_M` variants are what I tested. Both report `nextn_predict_layers=1`. Models without the MTP head won't start under `--spec-type draft-mtp`.
- The exact option names are specific to the pinned build (`b10835`). On a newer llama.cpp, check that build's help output before trusting these, and re-run the comparison against your own non-MTP control instead of assuming depth 1 stays optimal.
- Verify it with the server's own metrics: `llamacpp:spec_decode_num_accepted_tokens_total` over `llamacpp:spec_decode_num_draft_tokens_total` is your acceptance rate. The harness measured it as counter deltas across requests, not log-reading. Target: 27B in the high 70s, 35B into the 80s, and accepted-tokens-per-verification above 2.
- Spot-check the thermal story while you're at it. This matrix ran 120 W, 49–66 °C, no throttling. If your Thor is throttling, you're measuring a different problem than the one above.

## What the community is already tracking

This was never a one-off machine quirk, and I'm not the only one seeing it. These are the public receipts that the CUDA-path bug is a known thing — the community has already done its half:

- [ggml-org/llama.cpp#26750](https://github.com/ggml-org/llama.cpp/issues/26750) — a reproducible MTP acceptance collapse on a Blackwell CUDA system versus Vulkan, isolated to the CUDA path. My pre-fix 27B acceptance (37.85%) sat squarely inside the defect band reported there.
- [ggml-org/llama.cpp#23230](https://github.com/ggml-org/llama.cpp/issues/23230) — MTP behavior shifting with llama.cpp version and draft depth, which is why the stock default draft depth was never tuned for this model family.

Every number and flag above reproduces against that public tracking. Nothing in my own runs or machines is linked here.

## What's Next

Typically, NVIDIA eventually fixes problems like this. It might take a year or more, but once they fix their kernel flaw, we are likely to see massive increases in speed as longer drafts become feasible. 

Think about it this way; without the mitigation, fundamentally, a desnse 27 billion parameter LLM is a list of 27 billion numbers that must be multiplied in order to find the next token. Without the mitigation, the model has to do all that multiplication for every token. The speed at which it can do that is the speed of the model. 

With the mitigation, it has a high chance of skipping most of the work for subsequent incremental tokens (the chance goes from 26% to 72%). This means about a 50% net speed-up with the mitigation. But in the future, that chance will be for skipping more tokens. This will mean a much larger speed-up. Imagine if every full token of work was followed by four or five tokens at a much lower cost. This explains why non-CUDA speculative decoding is up to 10x faster at present, and likely shows what the CUDA path will eventually look like once NVIDIA fixes it.