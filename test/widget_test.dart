import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/main.dart';
import 'package:testing_demo/widgets/calculator_widget.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Number A'), findsOneWidget);
    expect(find.text('Number B'), findsOneWidget);
  });

  testWidgets('CalculatorWidget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    // Verify initial state
    expect(find.text('Number A'), findsOneWidget);
    expect(find.text('Number B'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);
    expect(find.text('Result:'), findsOneWidget);
  });

  testWidgets('CalculatorWidget performs addition correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    // Enter numbers using keys
    await tester.enterText(find.byKey(const Key('numberA_field')), '5');
    await tester.enterText(find.byKey(const Key('numberB_field')), '3');
    
    // Tap add button
    await tester.tap(find.text('+'));
    await tester.pump();

    // Verify result
    expect(find.text('Result: 8.0'), findsOneWidget);
  });

  testWidgets('CalculatorWidget shows error for division by zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    // Enter numbers
    await tester.enterText(find.byKey(const Key('numberA_field')), '5');
    await tester.enterText(find.byKey(const Key('numberB_field')), '0');
    
    // Tap divide button
    await tester.tap(find.text('÷'));
    await tester.pump();

    // Verify error message
    expect(find.text('Error: Cannot divide by zero'), findsOneWidget);
  });

  testWidgets('CalculatorWidget handles invalid input gracefully', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    // Enter invalid numbers
    await tester.enterText(find.byKey(const Key('numberA_field')), 'abc');
    await tester.enterText(find.byKey(const Key('numberB_field')), 'xyz');
    
    // Tap add button
    await tester.tap(find.text('+'));
    await tester.pump();

    // Should handle invalid input as 0
    expect(find.text('Result: 0.0'), findsOneWidget);
  });
}