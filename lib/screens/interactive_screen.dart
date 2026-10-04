import 'package:flutter/material.dart';

class InteractiveScreen extends StatefulWidget {
  const InteractiveScreen({super.key});

  @override
  State<InteractiveScreen> createState() => _InteractiveScreenState();
}

class _InteractiveScreenState extends State<InteractiveScreen> {
  final TextEditingController _nameController = TextEditingController();
  final String _initialMessage = "Enter your name and press the 'Say Hello' button.";
  late String _message = _initialMessage;
  bool _isHighlighted = false;

  void _updateGreeting() {
    setState(() {
      final name = _nameController.text.trim();
      _message = name.isEmpty ? 'Please type a name first!' : 'Hello, $name!';
    });
  }

  void _toggleColor() {
    setState(() {
      _isHighlighted = !_isHighlighted;
    });
  }

  void _reset() {
    setState(() {
      _nameController.clear();
      _message = _initialMessage;
      _isHighlighted = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Interactive Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateGreeting,
              child: const Text('Say Hello'),
            ),
            const SizedBox(height: 32),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: _isHighlighted ? Colors.deepOrange : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _toggleColor,
                child: Text.rich(
                TextSpan(
                  text: 'Change Text Color to ',
                  children: [
                    TextSpan(
                      text: _isHighlighted ? 'black' : 'red',
                      style: TextStyle(
                        color: _isHighlighted ? Colors.black : Colors.red ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
