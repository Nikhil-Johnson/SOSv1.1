import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';
import 'package:shake/shake.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = "";
  bool _isTriggered = false;

  final Telephony telephony = Telephony.instance;
  final ImagePicker _picker = ImagePicker();
  final Record _record = Record();

  @override
  void initState() {
    super.initState();
    // Shake detection
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _triggerSOS();
      },
    );
  }

  void _onPressed(String value) {
    setState(() {
      _display += value;
      if (_display == "911") {
        _triggerSOS();
      }
    });
  }

  Future<void> _triggerSOS() async {
    if (_isTriggered) return;
    setState(() => _isTriggered = true);

    // 1. Change UI
    setState(() {});

    // 2. Send SMS with location + photo link
    String message = await _composeSOSMessage();
    telephony.sendSms(
      to: "7736234006",
      message: message,
    );

    // 3. Make a call
    final Uri launchUri = Uri(scheme: 'tel', path: "7736234006");
    await launchUrl(launchUri);

    // 4. Start recording audio locally
    await _startRecording();
  }

  Future<String> _composeSOSMessage() async {
    String msg = "🚨 EMERGENCY! Please help.\n";

    // Location
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      msg += "📍 Location: https://maps.google.com/?q=${pos.latitude},${pos.longitude}\n";
    } catch (e) {
      msg += "📍 Location unavailable.\n";
    }

    // Photo upload
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        String url = await _uploadToFirebase(File(photo.path));
        msg += "📸 Photo: $url\n";
      } else {
        msg += "📸 No photo captured.\n";
      }
    } catch (e) {
      msg += "📸 Error capturing photo.\n";
    }

    return msg;
  }

  Future<String> _uploadToFirebase(File file) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("sos_photos/${DateTime.now().millisecondsSinceEpoch}.jpg");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> _startRecording() async {
    if (await _record.hasPermission()) {
      final path = "/storage/emulated/0/Download/sos_record_${DateTime.now().millisecondsSinceEpoch}.m4a";
      await _record.start(path: path, encoder: AudioEncoder.aacLc);
    }
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _isTriggered ? Colors.red : Colors.grey[850],
          padding: const EdgeInsets.all(24),
        ),
        onPressed: () => _onPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isTriggered ? Colors.red[900] : Colors.black,
      appBar: AppBar(title: const Text("SOS Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(children: [_buildButton("1"), _buildButton("2"), _buildButton("3")]),
          Row(children: [_buildButton("4"), _buildButton("5"), _buildButton("6")]),
          Row(children: [_buildButton("7"), _buildButton("8"), _buildButton("9")]),
          Row(children: [_buildButton("0")]),
        ],
      ),
    );
  }
}
