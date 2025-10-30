import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/widgets/calculator_widget.dart';

void main() {
  group('CalculatorWidget Golden Tests', () {
    testWidgets('CalculatorWidget - initial state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          // ✅ Agregar const
          home: Scaffold(
            body: CalculatorWidget(),
          ),
        ),
      );

      expect(find.byType(CalculatorWidget), findsOneWidget);
    });

    testWidgets('CalculatorWidget - with numbers entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          // ✅ Agregar const
          home: Scaffold(
            body: CalculatorWidget(),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('numberA_field')), '15');
      await tester.enterText(find.byKey(const Key('numberB_field')), '3');
      await tester.pump();

      expect(find.text('15'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });
}
