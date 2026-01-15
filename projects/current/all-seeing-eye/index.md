---
layout: project
order: 1
title: All Seeing Eye
blurb: A distributed RF observer system for real-time spectrum mapping.
---

### All Seeing Eye

<a href="https://github.com/cjtrowbridge/all-seeing-eye"><img src="/assets/images/all-seeing-eye-rendering.jpg" class="photo"></a>

<a href="https://github.com/cjtrowbridge/All-Seeing-Eye" class="btn btn-sm btn-outline-primary" target="_blank" rel="noopener"><i class="fab fa-github"></i> Visit Project Site</a>

The **All-Seeing Eye** is a distributed RF observer system designed to map the radio spectrum (literally put all the broadcasts on a geographic map) in real-time. By deploying multiple synchronized nodes (ESP32 + CC1101) in a grid, the system creates a "VLBI Cluster" (Very Long Baseline Interferometry) that correlates signal strength (RSSI) from many locations simultaneously.

A primary goal for this project is that each node should cost just a few dollars to build, making it feasible to quickly and affordably deploy dozens or hundreds of them across a region. They can also integrate with meshtastic nodes to enable cheap and offline regional communication and automated alterts for various undesirable behaviors the nodes may observe ocurring throughout the region.

This allows the system to determine where RF broadcasts are originating from, not by having one powerful sensor, but by combining the partial views of many small, low-cost observers.

The project involves optionally 3D printing a custom "Pyramid" enclosure with embedded diffusion lighting to represent the node's "latent awareness." You can use any container you like, but the pyramid is designed to be visually striking way of separating the antennas enough that they wont interfere with each other while also clearly communciating what the nodes actually do.

**Key Features:**
*   **Distributed Sensing:** Multiple nodes contribute to a single global map.
*   **3D Printed Enclosure:** A specialized semi-transparent pyramid design (8" base) with magnetic latches.
*   **Hardware:** ESP32-S3 and CC1101 modules.
*   **Open Source:** All code and 3D models are available on GitHub.

### Build List

These are the primary components required to build a single node. *These are affiliate links.*

* Sparkly semi-transparent purple PLA filament ([$19.99](https://amzn.to/3Yy0ZLC))
* I used an AD5M Pro 3D printer which is 10/10. Fully enclosed and filtered. 220x220x250mm build volume. Very easy to use. ([$379](https://amzn.to/4aUHjsQ))
* ESP-32 3-pack with IPX MHF1 connector ([$17.99](https://amzn.to/3YyJqLl))
* CC1101 module 3-pack ([$22.99](https://amzn.to/4qEJl4S))
* IPX MHF1 to SMA Cable 5-pack ([$8.29](https://amzn.to/3NbLDdm))
* Jumper wires (male-female) (there are infinite options here but there are what i used) ([$6.98](https://amzn.to/4qsRIkg))
* Heltec v3 Meshtastic Node (optional, any meshtastic node with IPX MHF1 connector will do) ([$21.99](https://amzn.to/49MXC9Y))
* GY-NEO6MV2 GPS Module (optional) ([$9.99](https://amzn.to/3NpCHRz))
* 2.4ghz wifi antenna 4-pack (optional, any wifi antenna with SMA connector will do) ([$8.69](https://amzn.to/4szIt3d))
* 915mhz antenna 2-pack (optional, any 915mhz antenna with SMA connector will do) ([$9.99](https://amzn.to/3LGUaV7))
* SMA Extensions 2-pack (optional, but its going to hard to fit everything without these [$6.99](https://amzn.to/45Ou0Xd))
* Self-advesive breadboard (optional) [$8.99](https://amzn.to/49mhwbJ)

### Source Code

Full design documentation, OpenSCAD models, and firmware source code are available in the repository.

<a href="https://github.com/cjtrowbridge/All-Seeing-Eye" class="btn btn-sm btn-outline-primary" target="_blank" rel="noopener"><i class="fab fa-github"></i> Visit Project Site</a>
