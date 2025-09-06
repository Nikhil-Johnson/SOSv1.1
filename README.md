SOS Emergency App
<p align="center"> <img src="./public/imgs/qz766z83.bmp" width="50%" /> </p> <p align="center"> <img src="./public/imgs/f2jw9r04.bmp" width="50%" /> </p> <p align="center"> <img src="./public/imgs/ojskirln.bmp" width="50%" /> </p> <p align="center"> <img src="./public/imgs/xngixjxf.bmp" width="50%" /> </p>
Table of Contents

Introduction

Features

Implemented Features

Planned Features

Technologies Used

Installation

Usage

Contributing

License

Introduction

The SOS Emergency App is a mobile application designed to provide fast and reliable help during emergencies. It allows users to trigger alerts quickly via a calculator interface or by shaking the phone. Once activated, the app sends SMS alerts with location, makes an emergency call, records audio, and captures photos periodically.

The app is aimed at enhancing personal safety and ensuring a prompt response from designated contacts.

Features
Implemented Features

SOS Trigger via Calculator: Enter 911 to immediately activate the SOS sequence.

Shake Detection: Trigger SOS automatically by shaking the phone.

SMS Alerts: Sends messages with current location and uploaded photo links to emergency contacts.

Automated Call: Initiates a call to the primary emergency contact.

Continuous Audio Recording: Records audio until manually stopped.

Periodic Photo Capture: Takes a photo every 5 minutes after SOS is activated.

Firebase Storage Integration: Stores captured photos for sharing via SMS links.

Visual SOS Indicator: Changes UI color to red to indicate active emergency state.

Manual Stop: Stop button ends audio recording and periodic photo capture.

Planned Features

Voice Activation: Hands-free SOS triggering via voice commands.

Real-Time Location Tracking: Continuous location sharing with multiple contacts.

Customizable Alert Messages: Users can edit SMS content.

Health Device Integration: Sync with smartwatches for automatic SOS triggers.

Multiple Language Support: Expand accessibility globally.

Community Support Feature: Connect with nearby responders or volunteers.

Emergency Resources Directory: Quick access to local hospitals, police, and shelters.

Technologies Used

Framework: Flutter

Backend Services: Firebase (Storage, optional Firestore for contacts)

APIs / Plugins:

Geolocator (location)

Telephony (SMS and calls)

Shake (device motion)

Image Picker & Camera

Record (audio recording)

Installation

Clone the repository:

git clone https://github.com/Thabhelo/sos.git


Navigate to the project directory:

cd sos


Install dependencies:

flutter pub get


Place your Firebase configuration file:

android/app/google-services.json


Run the app on your device:

flutter run


Make sure all permissions (location, SMS, camera, microphone) are enabled.

Usage

Launch the app on your device.

Trigger SOS by:

Entering 911 on the calculator, or

Shaking the device.

The app will automatically:

Send SMS with location & photo link

Make a call to the emergency contact

Start continuous audio recording

Capture a photo every 5 minutes

Tap the Stop button to end audio recording and photo capture.
