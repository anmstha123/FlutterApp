import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart';

void main() {
  testWidgets('Navigate and update greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Welcome to My Flutter App'), findsOneWidget);

    await tester.tap(find.text('Go to Interactive Screen'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Anmol');
    await tester.tap(find.text('Say Hello'));
    await tester.pump();

    expect(find.text('Hello, Anmol!'), findsOneWidget);
  });

  testWidgets('Gestures update the gesture screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Go to Gesture Screen'));
    await tester.pumpAndSettle();

    final box = find.byKey(const Key('gestureBox'));

    // Tap waits out the double-tap window before firing.
    await tester.tap(box);
    await tester.pumpAndSettle(const Duration(milliseconds: 400));
    expect(find.text('Tap: color changed (taps: 1)'), findsOneWidget);

    await tester.tap(box);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(box);
    await tester.pumpAndSettle();
    expect(find.text('Double tap: box enlarged'), findsOneWidget);

    await tester.fling(box, const Offset(-200, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Swipe left: emoji 2 of 6'), findsOneWidget);

    await tester.longPress(box);
    await tester.pumpAndSettle();
    expect(find.text('Long press: everything reset'), findsOneWidget);
  });
}
