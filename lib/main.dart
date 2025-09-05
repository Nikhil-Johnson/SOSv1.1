import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'phone_numbers_page.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator SOS',
      home: const Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late ShakeDetector _shakeDetector;
  final Telephony telephony = Telephony.instance;

  String _output = "";
  String _expression = "";
  bool _sosTriggered = false;
  Timer? _sosTimer;

  @override
  void initState() {
    super.initState();

    // Request SMS permission properly
    telephony.requestSmsPermissions;

    // Request location permission properly
    _requestLocationPermission();

    _shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
      _handleSosTrigger(triggeredBy: 'shake');
      _startSosLoop();
    });
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission permanently denied. Please enable it in settings.")),
        );
      }
    }
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    _stopSosLoop();
    super.dispose();
  }

  buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "";
        _expression = "";
        _sosTriggered = false;
        _stopSosLoop();
      } else if (text == "=") {
        if (_expression == "911") {
          _sosTriggered = true;
          _output = "🚨 SOS Triggered ";
          _handleSosTrigger(triggeredBy: 'manual');
          _startSosLoop();
        } else {
          try {
            final result = _calculate(_expression);
            _output = result.toString();
          } catch (e) {
            _output = "Error";
          }
        }
      } else {
        _expression += text;
        _output = _expression;
      }
    });
  }

  Future<void> _handleSosTrigger({required String triggeredBy}) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> numbers =
        prefs.getStringList('sos_numbers') ?? <String>[];
    if (numbers.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No phone numbers configured for SOS.')),
        );
      }
      return;
    }

    final String message = await _getLocationMessage();

    for (final to in numbers) {
      final cleaned = to.trim();
      if (cleaned.isEmpty) continue;
      try {
        telephony.sendSms(to: cleaned, message: message);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send SMS to $cleaned')),
          );
        }
      }
    }

    if (mounted) {
      setState(() {
        _sosTriggered = true;
        _output = "🚨 SOS Sent ($triggeredBy)";
      });
    }
  }

  Future<String> _getLocationMessage() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return "I am in danger! My location: https://maps.google.com/?q=${pos.latitude},${pos.longitude}";
    } catch (e) {
      return "I am in danger! (Location unavailable)";
    }
  }

  void _startSosLoop() {
    _stopSosLoop();
    _sosTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_sosTriggered) {
        _handleSosTrigger(triggeredBy: 'auto');
      } else {
        _stopSosLoop();
      }
    });
  }

  void _stopSosLoop() {
    _sosTimer?.cancel();
    _sosTimer = null;
  }

  double _calculate(String expr) {
    try {
      if (expr.contains("+")) {
        var parts = expr.split("+");
        return double.parse(parts[0]) + double.parse(parts[1]);
      } else if (expr.contains("-")) {
        var parts = expr.split("-");
        return double.parse(parts[0]) - double.parse(parts[1]);
      } else if (expr.contains("×")) {
        var parts = expr.split("×");
        return double.parse(parts[0]) * double.parse(parts[1]);
      } else if (expr.contains("÷")) {
        var parts = expr.split("÷");
        return double.parse(parts[0]) / double.parse(parts[1]);
      }
    } catch (e) {
      return double.nan;
    }
    return double.tryParse(expr) ?? 0.0;
  }

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            backgroundColor: color ??
                (_sosTriggered ? Colors.red : Colors.green),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(text),
        ),
      ),
    );
  }

  void _openPhoneNumbersPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PhoneNumbersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sosTriggered ? Colors.white : Colors.black,
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: _openPhoneNumbersPage,
          child: const Text("Calculator"),
        ),
        backgroundColor: _sosTriggered ? Colors.red : Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 36,
                  color: _sosTriggered ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("C", color: Colors.red),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("=", color: Colors.blue),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
