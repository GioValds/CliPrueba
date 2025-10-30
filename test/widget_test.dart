import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/main.dart';
import 'package:testing_demo/widgets/calculator_widget.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Number A'), findsOneWidget);
    expect(find.text('Number B'), findsOneWidget);
  });

  testWidgets('CalculatorWidget displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    // Verificar elementos básicos
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);

    // Verificar que existe algún texto que empiece con "Result"
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        final text = widget.data ?? '';
        return text.startsWith('Result');
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('CalculatorWidget performs addition correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    await tester.enterText(find.byKey(const Key('numberA_field')), '5');
    await tester.enterText(find.byKey(const Key('numberB_field')), '3');
    await tester.tap(find.text('+'));
    await tester.pump();

    // Buscar por contenido en lugar de texto exacto
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        final text = widget.data ?? '';
        return text.contains('8.0');
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('CalculatorWidget shows error for division by zero',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    await tester.enterText(find.byKey(const Key('numberA_field')), '5');
    await tester.enterText(find.byKey(const Key('numberB_field')), '0');
    await tester.tap(find.text('÷'));
    await tester.pump();

    expect(find.textContaining('Cannot divide by zero'), findsOneWidget);
  });

  testWidgets('CalculatorWidget handles invalid input gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CalculatorWidget(),
      ),
    ));

    await tester.enterText(find.byKey(const Key('numberA_field')), 'abc');
    await tester.enterText(find.byKey(const Key('numberB_field')), 'xyz');
    await tester.tap(find.text('+'));
    await tester.pump();

    expect(find.textContaining('0.0'), findsOneWidget);
  });
}
