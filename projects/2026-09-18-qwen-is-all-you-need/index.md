---
layout: project
type: project
status: draft
published: false
redirect_from:
  - /projects/current/qwen-is-all-you-need/
  - /projects/future/qwen-is-all-you-need/
  - /projects/past/qwen-is-all-you-need/
  - /projects/current/2026-09-18-qwen-is-all-you-need/
  - /projects/future/2026-09-18-qwen-is-all-you-need/
  - /projects/past/2026-09-18-qwen-is-all-you-need/
title: Qwen is all you need
description: A quick note on why Qwen keeps showing up as the simplest practical AI stack.
pubdate: 2026-09-18
lastUpdated: 2026-09-18
---

When [qwen3.8:27b](https://huggingface.co/Qwen/Qwen3.8-27B) was announced, I called it "the new best model in the world." That title has stuck. Nothing since then has been remarkably better. It's true that [qwen3.8:125b](https://qwen.ai/blog?id=qwen3.8-flash-next) is faster and scores better at most things, but it also needs five times as much resources to run. This puts it well outside what most people's machines can handle. 

The really remarkable thing about [qwen3.8:27b](https://huggingface.co/Qwen/Qwen3.8-27B) is the extraordinary performance on long-horizon tasks. You can give it something very complicated to do and trust that it will get it done, even if it takes a week of work. This is a critical threshhold that wasn't obvious at the time. 

This really unlocks a whole new level of getting shit done. 

There is a long tradition of "all you need." 

First there was, "[attention is all you need](https://arxiv.org/abs/1706.03762)." This groundbreaking paper laid out what would become modern artificial intelligence. 

More recently there was, "[an old xeon is all you need](https://point.free/blog/gemma-4-on-a-2016-xeon/)." This essay made the case that most ten year old xeons came with a lot of ram, and were more than capable of running most modern artificial intelligence models, including models like [qwen3.8:27b](https://huggingface.co/Qwen/Qwen3.8-27B). For a couple hundred bucks, [a trash can mac pro](https://blog.lon.tv/2025/03/07/the-2013-trashcan-mac-pro-is-cheap-and-surprisingly-relevant-in-2025/) is more than capable of running [qwen3.8:27b](https://huggingface.co/Qwen/Qwen3.8-27B) at up to a few tokens per second. (A few tokens per second is a quarter-million tokens per day.)

## Hard Problems

I've heard from a lot of people that the idea of waiting a few minutes or hours for their free bleeding-edge trash can AI server to complete a complex task for them is more than they can bear. God help them if they ever have to work with other people. This prompted me to start experimenting with Cerebras. 

** If 3 tokens per second is too slow, then what would be the benefits and downsides of getting thousands of tokens per second instead? **

I came up with several challenging tasks that feel infeasible at 3tps:
- Build a working ternary-master training suite and train a 1-billion-parameter ternary-master LLM.
- Solve mitigation for the blackwell kernel fault
- Figure out what all the chips are on [a sktchy but awesome chinese clone pi hat](https://cjtrowbridge.com/projects/2026-09-09-micro-cyberdeck/) and get all the features working with zero documentation.

These tasks took approximately one-billion tokens, two-hundred-million tokens, and one-hundred million tokens respectively. This amount of tokens would have taken months on my total current personal compute capacity, but Cerebras made it happen in just a few days.

It also cost around $1,300. So the question becomes is it worth it to wait a few months or spend that much money on Cerebras. Another key caveat is the fact that Cerebreas seems to be using a lower-quantized version of qwen3.8:27b because it rambles, wasting many tokens. So it's likely that running it at home with full quantizations would have taken far fewer tokens on the same model to accomplish the same tasks. 

For me, the bottom line is that there will always be complicated problems I can put an old xeon to work tackling, and I have collected quite a few old xeons that are happy to do that. 

## A Surprise In A Trash Can

There's something important to consider about running Qwen on a trash can. The thing about a 2013 Mac Pro is that it has up to 128gb of system ram plus an old xeon. That's great for running big models. It can easily run either the 27b or 125b models in the qwen3.8 series.

But it also has two GPUs, with up to 6gb vram each. These can't hold either of these models, but they can hold part of them. If you were to use these with the 27b dense model, a library like ggml (ollama, llama.cpp, lmstudio, etc) would offload the things that need to go fastest (kv cache, encoder, decoder) onto the GPUs, and run the rest from system ram. This would be significantly faster than leaving the whole model in system ram, but it's still going to run at the speed of the system ram which is much slower than running it out of vram alone.

125b is a different story. Because it's a mixture of experts and not a dense model like 27b, those "pieces that need to go fast" are essentially the only part that's running all the time. The rest of the time, the model is selecting a small portion of its layers to run; just 8b. Meaning it is likely to perform extraordinarily well on a trash can, in fact it's likely that it would perform about 3x as fast as the much smaller dense 27b model which must run all 27b parameters from system ram versus just 8b. And yet it performs much better than the 27b model.