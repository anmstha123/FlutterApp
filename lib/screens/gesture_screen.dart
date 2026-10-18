import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  static const List<Color> _colors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.blue,
  ];
  static const List<String> _emojis = ['😀', '🐶', '🍕', '🚀', '🌈', '🎸'];

  static const double _minSwipeVelocity = 300;

  int _colorIndex = 0;
  int _emojiIndex = 0;
  int _tapCount = 0;
  bool _isEnlarged = false;
  String _status = 'Try a gesture on the box!';

  void _onTap() {
    HapticFeedback.selectionClick();
    setState(() {
      _tapCount++;
      _colorIndex = (_colorIndex + 1) % _colors.length;
      _status = 'Tap: color changed (taps: $_tapCount)';
    });
  }

  void _onDoubleTap() {
    HapticFeedback.lightImpact();
    setState(() {
      _isEnlarged = !_isEnlarged;
      _status = 'Double tap: box ${_isEnlarged ? 'enlarged' : 'shrunk'}';
    });
  }

  void _onLongPress() {
    HapticFeedback.heavyImpact();
    setState(() {
      _colorIndex = 0;
      _emojiIndex = 0;
      _tapCount = 0;
      _isEnlarged = false;
      _status = 'Long press: everything reset';
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Reset complete!'),
          duration: Duration(seconds: 1),
        ),
      );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < _minSwipeVelocity) return;

    HapticFeedback.selectionClick();
    final swipedLeft = velocity < 0;
    setState(() {
      _emojiIndex = swipedLeft
          ? (_emojiIndex + 1) % _emojis.length
          : (_emojiIndex - 1 + _emojis.length) % _emojis.length;
      _status = 'Swipe ${swipedLeft ? 'left' : 'right'}: '
          'emoji ${_emojiIndex + 1} of ${_emojis.length}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = _isEnlarged ? 260.0 : 180.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Gesture Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              _status,
              key: const Key('gestureStatus'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  key: const Key('gestureBox'),
                  onTap: _onTap,
                  onDoubleTap: _onDoubleTap,
                  onLongPress: _onLongPress,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: _colors[_colorIndex],
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(blurRadius: 8, color: Colors.black26),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _emojis[_emojiIndex],
                      style: TextStyle(fontSize: _isEnlarged ? 96 : 64),
                    ),
                  ),
                ),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Tap: change color\n'
                  'Double tap: enlarge / shrink\n'
                  'Long press: reset everything\n'
                  'Swipe left / right: change emoji',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
