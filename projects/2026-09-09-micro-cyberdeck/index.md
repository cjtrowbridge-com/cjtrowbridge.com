---
layout: project
type: project
status: posted
published: true
redirect_from:
  - /projects/current/micro-cyberdeck/
  - /projects/future/micro-cyberdeck/
  - /projects/past/micro-cyberdeck/
  - /projects/current/2026-09-09-micro-cyberdeck/
  - /projects/future/2026-09-09-micro-cyberdeck/
  - /projects/past/2026-09-09-micro-cyberdeck/
title: Micro Cyberdeck
description: A tiny cyberdeck built for high-power computing in the palm of your hand.
image: /projects/2026-09-09-micro-cyberdeck/micro-cyberdeck-orthogonal.jpg
imageAlt: Micro Cyberdeck viewed from above
pubdate: 2026-09-09
lastUpdated: 2026-09-13
---


The micro cyberdeck is a tiny, portable computer designed for computing in the palm of your hand. It has similar/better specs to a steam deck or steam machine depending on what you're doing with it, but in a much smaller form factor. It has a 1.54" x 1.54" 240x240 screen, a speaker, a headphone jack, a bunch of buttons, and a battery that should theoretically last about 13.9 hours doing normal tasks. It also has usb and hdmi out so it can be plugged into a docking station and used as a full desktop computer with a monitor, keyboard, and mouse. It even has a PCI-E-3 port for adding a desktop GPU or other expansion cards. Most of these specs match or exceed the steam deck/ steam machine. Though steam devices have a better GPU, they don't have an NPU specialized at local AI tasks.

## Capabilites

This is a full ARM64 computer. It should technically support most Steam games through Proton, though not all of this is realistically going to work perfectly out of the box because a lot of it is still being implemented in the drivers and software.

This has a powerful, modern ARM64 CPU with eight cores, plus a separate RISC-V
coprocessor, a GPU, an NPU (3 TOPS @ INT8), and up to 16gb of LPDDR5 RAM.

It has a 1.54" x 1.54" 240x240 screen, a speaker, a headphone jack, a bunch of buttons, and a battery that should theoretically last about 13.9 hours doing normal tasks.

AND, you can plug this into any USB-C docking station and essentially have a full working desktop machine with a normal monitor, keyboard, and mouse. It even supports a full desktop GPU through the PCI-E-3 port.


<img src="/projects/2026-09-09-micro-cyberdeck/micro-cyberdeck-side.jpg" class="photo" alt="Micro Cyberdeck Side View" >


## Parts List

- [New Pi](https://amzn.to/4cEsACl)
  New Pi SBC (Zero form-factor):
    - Up to 16gb DDR5 (You choose the amount you want)
    - Onboard GPU
    - NPU (3 TOPS @ INT8)
    - PCI-E-3.0
- [The Hat](https://amzn.to/4xX0VVJ)
  There are a lot of similar hats but this is the only one I have been able to find in the form factor of the Pi Zero which has a 240x240 screen, a lot of buttons, a speaker, a headphone jack, and a charge controller and battery connection. Also, it powers the pi from the top which is the only way with this pi.
- [The Battery](https://amzn.to/46zPjfv)
  Theoretically, this battery should last about 13.9 hours doing normal tasks. Your mileage may vary depending on what you are doing with the device. Playing cyberpunk or doing AI is going to cut that down significantly.
  - (11.1 wh battery / 0.8 wh rated standby consumption = 13.9 hrs battery life)
- [My favorite SD Card](https://amzn.to/3UFslAQ)
  I've stress tested a lot of SD cards and this one is the best I've found.
- I recommend running [Armbian](https://armbian.com/boards/orangepizero3w) instead of the sketchy OEM image. This is a brand new board so support is still a work in progress. Don't expect everything to be perfect yet, or ever. But my experience has been good so far.


### Future Opportunities

All of these things are currently possible by simply plugging external devices into the ports, but I'd like to fit these capabilites into the micro form-factor.

#### PCI-3 Expansion

I think the biggest long-term opportunity is to take advantage of the PCI-3 port by adding some kind of more powerful SSD or AI Accelerator (Like the LLM8850 which is out of stock everywhere).

The big problem with both of these options is that there isn't any nvme hat that fits this board at this point.

#### Peripheral Ports

There are [some hats](https://www.crowdsupply.com/cariboulabs/cariboulite-rpi-hat) for Pi Zero that give you a few usb ports and an ethernet port, but they all need a micro usb connection to the pi which is not possible with this pi. It seems unlikely that this will ever be resolved since this is a small batch SBC, but it would be cool to see that someday.

#### Software-Defined Radio

It would be awesome to find something like a [CaribouLite](https://www.crowdsupply.com/cariboulabs/cariboulite-rpi-hat) in the zero form factor, but these are also no longer available.

#### Meshtastic

I haven't been able to find a meshtastic hat for the zero form factor, but it would be cool to add one someday.
