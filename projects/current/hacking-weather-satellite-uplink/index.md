---
layout: project
order: -2
title: "Stationary 3D-Printed helicone Weather Satellite Uplink"
---

# Stationary 3D-Printed helicone Weather Satellite Uplink

<a href="/assets/images/helicone.jpg"><img src="/assets/images/helicone.jpg" alt="Helicone" class="photo" /></a>

| Field | Details |
| --- | --- |
| Feed type | Helicone (3D-printed) |
| Reflector type | Parabolic dish (Aluminum Window Screen) |
| Alignment mechanism | Stationary (fixed mount after initial pointing) |

This is an uplink for connecting to the [GOES](https://en.wikipedia.org/wiki/Geostationary_Operational_Environmental_Satellite) weather satellites using a 3D-printed helicone feed antenna with an integrated parabolic dish reflector and LNA. The [helical feed](https://en.wikipedia.org/wiki/Helical_antenna) is designed to be mounted on a fixed, stationary mount that is manually pointed at the satellite. This allows me to receive real-time weather forecasts, photography, and emergency alerts directly from space without needing an internet connection.

![GOES Satellite](/assets/images/goes-8.jpg)

## The Project

I wanted to try duplicating the popular open-source Helicone project as a baseline reference to test my other ideas against.

This is the [3d model](https://www.thingiverse.com/thing:6436342/files). 


### Here is the parts list:
- [Solid-core 6mm^2 copper wire](https://amzn.to/4kmiW9O) for the helicone elements. I used 6mm^2 because it is the closest standard size to the ideal diameter for the GOES frequency.
- [SMA flange](https://amzn.to/4kmAlPT) to mount the feed to the dish and connect the LNA.
- [M8 bolts, nuts, and washers](https://amzn.to/4bGalwE) to secure the feed to the dish.
- [Assorted self-tapping M2 screws](https://amzn.to/4kv95ik)
- [Special Low Noise Amplifier (LNA)](https://amzn.to/45TIxB9) designed for the GOES satellite frequency.
- [RTL-SDR dongle](https://amzn.to/4tk5M1i) to receive the satellite signal.
- [Raspberry Pi Zero 2W](https://amzn.to/45SZN9K) to run rtl_tcp and stream data to my main computer, running [SatDump](https://github.com/SatDump/SatDump) and [goestools](https://github.com/pietern/goestools)
- [Battery pack For Raspberry Pi](https://amzn.to/4aBLXer) to power the receiver in the field. These are great.
- [Memory card For Raspberry Pi](https://amzn.to/4tk5KX8) to store the OS and software.

### Software
- [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/) for the Raspberry Pi Zero 2W.
- [rtl_tcp](https://osmocom.org/projects/rtl-sdr/wiki/Rtl-sdr) to stream the raw IQ data from the RTL-SDR to my main computer.
- [SatDump](https://github.com/SatDump/SatDump) to decode the IQ data and extract the weather data and images from the GOES satellite signal.
- [goestools](https://github.com/pietern/goestools) for additional processing and analysis of the GOES data.


### Other examples

[ This 3D-Printed Satellite Antenna Is Fantastic! ](https://www.youtube.com/watch?v=PFQ6UKulxSo)