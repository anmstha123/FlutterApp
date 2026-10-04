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
}
