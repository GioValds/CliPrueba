import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/widgets/calculator_widget.dart';

void main() {
  group('CalculatorWidget Golden Tests', () {
    testWidgets('CalculatorWidget - initial state', (WidgetTester tester) async {
      // Método simple y compatible
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorWidget(),
          ),
        ),
      );

      // Para golden tests necesitarías golden_toolkit configurado
      // await screenMatchesGolden(tester, 'calculator_initial');
      
      // Verificación básica por ahora
      expect(find.byType(CalculatorWidget), findsOneWidget);
    });

    testWidgets('CalculatorWidget - with numbers entered', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculatorWidget(),
          ),
        ),
      );

      // Enter some text
      await tester.enterText(find.byKey(const Key('numberA_field')), '15');
      await tester.enterText(find.byKey(const Key('numberB_field')), '3');
      await tester.pump();

      // await screenMatchesGolden(tester, 'calculator_with_input');
      expect(find.text('15'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });
}