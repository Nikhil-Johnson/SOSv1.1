import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumbersPage extends StatefulWidget {
  const PhoneNumbersPage({super.key});

  @override
  State<PhoneNumbersPage> createState() => _PhoneNumbersPageState();
}

class _PhoneNumbersPageState extends State<PhoneNumbersPage> {
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _loadNumbers();
  }

  Future<void> _loadNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final numbers = prefs.getStringList('sos_numbers') ?? <String>[];
    for (int i = 0; i < numbers.length && i < 5; i++) {
      _controllers[i].text = numbers[i];
    }
  }

  Future<void> _saveNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> numbers = _controllers.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList();
    await prefs.setStringList('sos_numbers', numbers);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone numbers saved.')));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure SOS Numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('Enter up to 5 phone numbers. These will receive the SOS SMS.'),
            const SizedBox(height: 12),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: TextField(
                  controller: _controllers[i],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone number ${i+1}',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveNumbers,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
