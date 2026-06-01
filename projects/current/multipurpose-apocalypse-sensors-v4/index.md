---
layout: project
order: 1
title: Multipurpose Apocalypse Sensors v4
blurb: Draft plan for a modular, off-grid sensor platform for resilience work.
---

### Multipurpose Apocalypse Sensors v4

> Draft status: Working outline for active edits.

This draft lays out **v4** of a modular sensor platform for off-grid monitoring,
early warning, and community infrastructure diagnostics.

## Why v4

In the [last iteration](https://blog.cjtrowbridge.com/2020/09/11/multpurpose-apocalypse-sensors-v3/), I added geiger counters and laser particulate sensors in order to study the realtionship between air quality and radiation levels. This was a fun project, but the lack of a proper [Stevenson screen](https://en.wikipedia.org/wiki/Stevenson_screen) led to corrosion and damage over the last six years. Also, I have developed an interest in leveraging the bleeding edge forecast models which are available via satellite downlink, and the current platform is not powerful enough to handle the data processing requirements.

## What's New In v4:
- A fully 3d printed Stevenson-style enclosure with a modular design for easy maintenance and upgrades.
- A more powerful single-board-computer to handle more complex data processing and additional sensors.
- A [GOES satellite](https://en.wikipedia.org/wiki/Geostationary_Operational_Environmental_Satellite) receiver for real-time weather data and early warning capabilities.
    - [GOES Satellite Dish](https://amzn.to/49xJCR5)
    - [Filter/Amplifier](https://amzn.to/4vh53y4)
    - [SDR Receiver](https://amzn.to/3RH5Nhw)
- Meshtastic integration for local communication and public pattern change broadcasts.
- Continued support for:
    - [Laser air quality sensor (PM2.5, PM10)](https://amzn.to/4o0Rqkd)
    - [Radiation detection (Geiger counter)](https://amzn.to/43c4Osb)
    - [Environmental sensing (temperature, humidity, pressure)](https://amzn.to/433pe6J)

 ## Custom Enclosure
 
 I have made great progress with my [vibe modeling](https://github.com/cjtrowbridge/vibe-modeling) pipeline. This agentic framework knows how to design and iterate on 3d objects based on a chat interface. I simply explain what I want and it designs a printable 3d model. Then we discuss any issues and it designs a new one. It also learns and tracks the design history. This has been a real game changer for me, as it allows me to rapidly prototype and iterate on designs without needing to crawl through the process of using cumbersome 3d modeling software. The pipeline can simply directly use whatever software it needs to whatever process is required, with a holistic view on the overall plan and goals.  

 This design includes two pieces which will be printed upside down. The top of the enclosure will be a simple waterproof box measuring 200mm x 200mm x 100mm. This will contain all the electronics except for the sensors. The top of this print will be open.
 
The bottom piece will be the stevenson screen which follows the same layout as the first piece, but with recessed edges to allow the top piece to mount snugly. (Ensuring enough margin to allow it to slide together)  

The bottom piece starts as a 200mm x 200mm x 100mm box with a hole in the center to allow wires and connections to pass through to the watertight electronics enclosure above. The sides of the box are louvered to allow maximum air flow while still providing protection from the elements. The top of the second print is also left open to allow for air flow while still providing protection from the elements.

When both pieces are done, they are inverted and assembled together. The top piece is slid into the bottom piece, creating a secure and weather-resistant enclosure for the sensors and electronics. The modular design allows for easy access to the components for maintenance and upgrades, while the Stevenson-style design ensures that the sensors are protected from direct exposure to sunlight and precipitation, allowing for accurate environmental readings.

## Project Status

My 3d printer is down, pending some replacement parts. I have been working on the design and iteration of the enclosure using my vibe modeling pipeline, but I have not yet been able to print and test the physical components. I will update when I have the printer back up and running, and I can start testing the enclosure design and sensor integration.

## Future Work

### Precision Forecasting

I have been working for a while to figure out an easy way for communities to put together hyper-local forecasting models that build on things like the GOES forecasts and take advantage of [older hardware](https://point.free/blog/gemma-4-on-a-2016-xeon/) which is still great for these kinds of tasks.  

The resolution of something like the NOAA GFS model is 12 square miles. People want to know what's happening in their neighborhood, not the average of a 12 square mile area. Who among us feels confident that they understand what "20% chance of rain" means for their block?  

By using local sensor data to calibrate and adjust the forecasts, we can create hyper-local models that provide much more accurate and relevant information for communities. This could be especially valuable for things like flood forecasting, where local topography and infrastructure can have a huge impact on outcomes.  

### Convergence Analysis

There are lots of global forecast models out there, and they all have their own strengths and weaknesses. By observing all these models in parallel and over time, we can compare their outputs versus reality. This lets us identify areas of agreement and disagreement, which can help us understand the underlying uncertainties and improve our forecasts.  

There is a kind of fluid and moving boundary in the forecasts between short-term consensus and longer-term hallucination. By tracking this boundary as it moves and changes, we can get a sense of how much confidence to place in the forecasts at any given time.  

For example, if all the models are in agreement for the next 24 hours, we can be more confident in the forecast for that period. However, if the models start to diverge after 48 hours, we know that there is more uncertainty in the forecast beyond that point.

This kind of convergence analysis can be a powerful tool for improving the accuracy and reliability of our forecasts, especially in complex and rapidly changing situations.  

