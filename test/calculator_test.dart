import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/models/calculator.dart';

void main() {
  group('Calculator Tests', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('Addition should return correct result', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-1, 1), equals(0));
      expect(calculator.add(0, 0), equals(0));
    });

    test('Subtraction should return correct result', () {
      expect(calculator.subtract(5, 3), equals(2));
      expect(calculator.subtract(0, 5), equals(-5));
      expect(calculator.subtract(10, 10), equals(0));
    });

    test('Multiplication should return correct result', () {
      expect(calculator.multiply(2, 3), equals(6));
      expect(calculator.multiply(-2, 3), equals(-6));
      expect(calculator.multiply(0, 5), equals(0));
    });

    test('Division should return correct result', () {
      expect(calculator.divide(6, 3), equals(2));
      expect(calculator.divide(5, 2), closeTo(2.5, 0.000001));
      expect(calculator.divide(1, 3), closeTo(0.333333, 0.000001));
    });

    test('Division by zero should throw ArgumentError', () {
      expect(() => calculator.divide(5, 0), throwsA(isA<ArgumentError>()));
    });
  });
}
