---
layout: project
order: 0
title: Whisplay Chat Bot Build List
blurb: Building a Whisplay chat bot.
---

### Whisplay Chat Bot Build List

Building a chat bot for Whisplay. This will let you create a portable AI assistant which understands your voice, runs what you say through a large langauge model, and then replies with voice. The "Good" model takes a few seconds between each step to reload the next model. The "Better" model is much faster but requires additional hardware. These are affiliate links. 

You have two options, and if you start with the "Good" option you can always upgrade to the "Better" option later. It's as simple as adding the extra hardware and flashing a new image to your MicroSD card.

<img src="/assets/images/whisplay-parts.jpeg" alt="Whisplay Parts" class="photo />

## Good

<img src="/assets/images/whisplay-basic.jpeg" alt="Whisplay Basic Setup" class="photo />

[My video explaining the basic setup](https://www.tiktok.com/@cjtrowbridge/video/7584311527990103326?is_from_webapp=1&sender_device=pc&web_id=7583425954312898062)

Here are the minimum required parts to make one that will work whether or not you include the upgraded parts later:
- [Raspberry Pi 4 Model B - 16GB RAM](https://amzn.to/4sEfUSd) This kit comes with the heatsink and power supply but none of the unnecessary extras like a case that wont fit with the pieces we're adding.
- [Big, Fast MicroSD Card](https://amzn.to/49RNw7J)
- [It has to be this specific battery](https://amzn.to/3YyVufN)
- [Whisplay Hat (screen/scpeaker/mic/button)](https://amzn.to/4qg9WFt)

Here are the instructions from the manufacturer on how to set it up: [Setup Instructions]()

Here is a pre-built image from the manufacturer where everything is already set up: [Pre-built Image](https://github.com/PiSugar/whisplay-ai-chatbot/wiki/Prebuild-Image-%E2%80%90-Pi5-Offline) Simply flash it to your MicroSD card using a tool like balena etcher or rufus and you're good to go!

## Better

<img src="/assets/images/whisplay-advanced.jpeg" alt="Whisplay Advanced Setup" class="photo" />

[My video about the advanced setup](https://www.tiktok.com/@cjtrowbridge/video/7594217936508816671)

To make it much faster, you can also add these parts:
- [LLM 8850](https://shop.m5stack.com/products/ai-8850-llm-accleration-m-2-module-ax8850)
- [Double M.2 Hat](https://www.waveshare.com/pcie-to-2-ch-m.2-hat-plus.htm)

Here's a video from the manufacturer about how to put it together with the LLM8850 [Assembly Instructions](https://www.youtube.com/watch?v=IuTD5OMaVVU)

Here is a pre-built image from the manufacturer where everything is already set up: [Pre-built Image](https://github.com/PiSugar/whisplay-ai-chatbot/wiki/Prebuild-Image-%E2%80%90-LLM8850) Simply flash it to your MicroSD card using a tool like balena etcher or rufus and you're good to go!

