import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/widgets/calculator_widget.dart';

void main() {
  group('CalculatorWidget Visual Tests', () {
    testWidgets('CalculatorWidget displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalculatorWidget(),
          ),
        ),
      );

      expect(find.byType(CalculatorWidget), findsOneWidget);
      expect(find.text('Number A'), findsOneWidget);
      expect(find.text('Number B'), findsOneWidget);
    });

    testWidgets('CalculatorWidget handles number input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
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