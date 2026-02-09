---
layout: project
order: -1
title: 32GB-DDR5 Ollama Server Based On OrangePi 6+
blurb: A small, quiet, 32GB DDR5 home lab LLM server running Ollama on an Orange Pi 6+.
---

### 32GB-DDR5 Ollama Server Based On OrangePi 6+

I built a compact local LLM server based on an **Orange Pi 6+** with **32GB DDR5**, running **Ollama** for offline inference and tooling.

![Orange Pi 6+ Ollama Server with 32GB DDR5](/assets/images/orangepi6p-32gb-ddr5-ollama-server.jpg)

**Goals:**
- Small and power-efficient
- Quiet enough to live on a shelf
- Simple deploy + updates
- Optional NVMe storage

## Parts List
- [Orange Pi 6+ (32GB DDR5)](https://amzn.to/4qurhKj)
- [3D Printed Case](https://www.printables.com/model/1583782-orange-pi-6-simple-case)
- [Evo SD Card](https://amzn.to/3O2rAyl) These are fast and reliable for the OS. You can also use an NVMe drive for storage, but disk speed is really not as big of a bottleneck as RAM for LLM inference, so I went with a large SD card for simplicity.

## Process
1. **Assemble Hardware**: Install the Orange Pi 6+ into the 3D printed case, ensuring proper cooling and access to ports. I am leaving the top off because it looks cooler. 😎
2. **Install Ubuntu Server for Arm**: available [here](https://ubuntu.com/download/server/arm)
3. **Setup Docker and Ollama:** I put this simple script together which does all the work for you.
4. **Connect Client:** Here are some of the most popular clients for connecting to your Ollama server:
   - [OpenWebUI](https://openwebui.com/) A web interface just like ChatGPT, but self-hosted and customizable.
   - [LM Studio](https://lmstudio.ai/) A desktop app for managing and chatting with your local LLMs. You can connect it to your Ollama server or use it locally on your machine.
   - [Ollama CLI](https://ollama.com/docs/cli)
   - [Ollama Python SDK](https://ollama.com/docs/python-sdk)
   - [Ollama Web UI](https://ollama.com/docs/web-ui)