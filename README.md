SOS Emergency App
<p align="center"> <img src="./public/imgs/1.jpeg" width="400" /> <br /> <em>Calculator-based SOS interface</em> </p> <p align="center"> <img src="./public/imgs/f2jw9r04.bmp" width="400" /> <br /> <em>Shake-trigger SOS and notification</em> </p> <p align="center"> <img src="./public/imgs/ojskirln.bmp" width="400" /> <br /> <em>Continuous audio recording in SOS mode</em> </p> <p align="center"> <img src="./public/imgs/xngixjxf.bmp" width="400" /> <br /> <em>Periodic photo capture every 5 minutes</em> </p>
Table of Contents
## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
  - [Implemented Features](#implemented-features)
  - [Planned Features](#planned-features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

Introduction

The SOS Emergency App is a mobile safety application designed for rapid response during emergencies. It allows users to quickly send alerts and share critical information such as location, photos, and live audio recordings with emergency contacts.

The app ensures users can activate SOS mode discreetly through either a calculator interface (911) or by shaking the device. Once activated, it automatically performs the following:

Sends SMS alerts with location and photo links

Initiates a call to a primary emergency contact

Records audio continuously

Captures photos every 5 minutes until manually stopped

Features
Implemented Features

SOS Trigger via Calculator: Enter 911 to activate SOS immediately.

Shake Detection: Trigger SOS automatically by shaking the phone.

SMS Alerts: Sends emergency messages containing location and photos.

Automated Call: Calls the primary emergency contact.

Continuous Audio Recording: Records audio until manually stopped.

Periodic Photo Capture: Takes a photo every 5 minutes after SOS is triggered.

Firebase Storage Integration: Stores photos and provides links via SMS.

Visual SOS Indicator: UI changes color to red during active SOS mode.

Manual Stop: Stop button in the AppBar ends audio recording and photo capture.

Planned Features

Voice activation for hands-free SOS triggering

Real-time location sharing with multiple contacts

Customizable alert messages

Integration with health monitoring devices (e.g., smartwatches)

Community support for nearby responders or volunteers

Multi-language support

Emergency resources directory

Technologies Used

Framework: Flutter

Backend Services: Firebase Storage

Plugins / APIs:

Geolocator (Location)

Telephony (SMS & Calls)

Shake (Device Motion Detection)

Image Picker & Camera

Record (Audio Recording)
