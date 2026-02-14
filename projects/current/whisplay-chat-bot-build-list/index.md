---
layout: project
order: 0
title: Whisplay Chat Bot Build List
blurb: Building a Whisplay chat bot.
---

### Whisplay Chat Bot Build List

Building a chat bot for Whisplay. This will let you create a portable AI assistant which understands your voice, runs what you say through a large langauge model, and then replies with voice. The "Good" model takes a few seconds between each step to reload the next model. The "Better" model is much faster but requires additional hardware. These are affiliate links. 

You have two options, and if you start with the "Good" option you can always upgrade to the "Better" option later. It's as simple as adding the extra hardware and flashing a new image to your MicroSD card.

<a href="/assets/images/whisplay-parts.jpeg"><img src="/assets/images/whisplay-parts.jpeg" alt="Whisplay Parts" class="photo" /></a>

## The Original Setup: Pretty Good.

<a href="/assets/images/whisplay-basic.jpeg"><img src="/assets/images/whisplay-basic.jpeg" alt="Whisplay Basic Setup" class="photo" /></a>

[My video explaining the basic setup](https://www.tiktok.com/@cjtrowbridge/video/7584311527990103326?is_from_webapp=1&sender_device=pc&web_id=7583425954312898062)

Here are the minimum required parts to make one that will work whether or not you include the upgraded parts later:
- [Raspberry Pi 5 - 16GB RAM](https://amzn.to/4sEfUSd) This kit comes with the heatsink and power supply but none of the unnecessary extras like a case that wont fit with the pieces we're adding.
- [Big, Fast MicroSD Card](https://amzn.to/49RNw7J)
- [It has to be this specific battery](https://amzn.to/3YyVufN)
- [Whisplay Hat (screen/scpeaker/mic/button)](https://amzn.to/4qg9WFt)
- [Header Spacers to make everything fit together](https://amzn.to/4qDpZxz)
- [3D Model of Case to fit everything together](https://github.com/PiSugar/suit-cases/tree/main/pi5-whisplay-chatbot)

Here is a pre-built image from the manufacturer where everything is already set up: [Pre-built Image](https://github.com/PiSugar/whisplay-ai-chatbot/wiki/Prebuild-Image-%E2%80%90-Pi5-Offline) Simply flash it to your MicroSD card using a tool like balena etcher or rufus and you're good to go!

If you want to do it all manually, here are the instructions: [Manual Setup Instructions](https://www.youtube.com/watch?v=kFmhSTh167U)

## The New Setup: Really Great!

<a href="/assets/images/whisplay-advanced.jpeg"><img src="/assets/images/whisplay-advanced.jpeg" alt="Whisplay Advanced Setup" class="photo" /></a>

[My video about the advanced setup](https://www.tiktok.com/@cjtrowbridge/video/7594217936508816671)

To make it much faster, you can also add these parts:
- [LLM 8850](https://shop.m5stack.com/products/ai-8850-llm-accleration-m-2-module-ax8850)
- [Double M.2 Hat](https://www.waveshare.com/pcie-to-2-ch-m.2-hat-plus.htm)
- [3D Model of Case to fit everything together](https://github.com/PiSugar/suit-cases/tree/main/pi5-whisplay-chatbot-llm8850/print)

Here is a pre-built image from the manufacturer where everything is already set up: [Pre-built Image](https://github.com/PiSugar/whisplay-ai-chatbot/wiki/Prebuild-Image-%E2%80%90-LLM8850) Simply flash it to your MicroSD card using a tool like balena etcher or rufus and you're good to go!

If you want to do it manually with the LLM8850, here are the manufacturer's instructions for manual setup: [Manual Setup Instructions](https://www.youtube.com/watch?v=IuTD5OMaVVU)

## Opportunities for Improvement
- Switching to [Qwen3-ASR](https://huggingface.co/Qwen/Qwen3-ASR-0.6B) for better voice recognition. This is a new open source model from Alibaba that is much better than the current one from OpenAI, but it requires a bit more setup to get working. If integrated, it would be much faster and more accurate for voice recognition in noisy environments.
- Switching to [Qwen3-TTS](https://huggingface.co/Qwen/Qwen3-TTS-12Hz-1.7B-CustomVoice) for better voice generation. This is another new open source model from Alibaba that is much better than the current one. It comes pre-trained with many excellent voices. It also allows cloning voices, so you could have it speak in your own voice or any voice you want. It can also allow editing voices to change whatever aspects of a particular voice you want to change. Again, it requires a bit more setup to get working, but it would be a big improvement in the quality of the voice responses.

## Subsequent Update From The Manufacturer

[Pipeline improvements for better speed and accuracy](https://www.youtube.com/watch?v=xGzvFzdBAwc)