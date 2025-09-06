SOS Emergency App
<p align="center"> <img src="./public/imgs/qz766z83.bmp" width="400" /> <br /> <em>Calculator-based SOS interface</em> </p> <p align="center"> <img src="./public/imgs/f2jw9r04.bmp" width="400" /> <br /> <em>Shake-trigger SOS and notification</em> </p> <p align="center"> <img src="./public/imgs/ojskirln.bmp" width="400" /> <br /> <em>Continuous audio recording in SOS mode</em> </p> <p align="center"> <img src="./public/imgs/xngixjxf.bmp" width="400" /> <br /> <em>Periodic photo capture every 5 minutes</em> </p>
<h1>
  Table of Contents
</h1>

<h2>Introduction</h2>

<h2>Features</h2>

<h2>Implemented Features</h2>

<h2>Planned Features</h2>

<h2>Technologies Used</h2>

<h2>Installation</h2>

<h2>Usage</h2>

<h2>Contributing</h2>

<h2>License</h2>

Introduction

The SOS Emergency App is a mobile safety application designed for rapid response during emergencies. Users can trigger SOS alerts discreetly via a calculator interface (911) or by shaking the device. Once activated, the app automatically:

Sends SMS alerts with current location and photo links

Initiates a call to a primary emergency contact

Records audio continuously

Captures photos every 5 minutes until manually stopped

This app ensures fast, reliable personal safety and prompt emergency communication.

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

Installation

Clone the repository:

git clone https://github.com/Thabhelo/sos.git


Navigate to the project directory:

cd sos


Install dependencies:

flutter pub get


Add your Firebase configuration file:

android/app/google-services.json


Run the app:

flutter run


Ensure all necessary permissions are granted (location, SMS, camera, microphone, storage).

Usage

Launch the app on your device.

Trigger SOS by:

Entering 911 on the calculator or

Shaking the device.

The app will automatically:

Send SMS with location & photo link

Make a call to the emergency contact

Start continuous audio recording

Capture photos every 5 minutes

Tap the Stop button in the AppBar to end SOS mode.
