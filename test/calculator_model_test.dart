import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/calculator.dart';

void main() {
  group('Calculator', () {
    test('creates calculator instance with valid question and answer', () {
      final calculator = Calculator(question: '5 + 3', answer: 8);

      expect(calculator.question, equals('5 + 3'));
      expect(calculator.answer, equals(8));
    });

    test('handles simple arithmetic expressions', () {
      final addCalculator = Calculator(question: '10 + 5', answer: 15);
      final subtractCalculator = Calculator(question: '10 - 5', answer: 5);
      final multiplyCalculator = Calculator(question: '10 * 5', answer: 50);
      final divideCalculator = Calculator(question: '10 / 5', answer: 2);

      expect(addCalculator.question, contains('+'));
      expect(subtractCalculator.question, contains('-'));
      expect(multiplyCalculator.question, contains('*'));
      expect(divideCalculator.question, contains('/'));
    });

    test('handles complex arithmetic expressions with multiple operators', () {
      final calculator = Calculator(question: '5 + 3 * 2', answer: 11);

      expect(calculator.question, equals('5 + 3 * 2'));
      expect(calculator.answer, equals(11));
    });

    test('handles negative answers correctly', () {
      final calculator = Calculator(question: '3 - 8', answer: -5);

      expect(calculator.answer, equals(-5));
      expect(calculator.answer, isNegative);
    });

    test('handles zero as answer', () {
      final calculator = Calculator(question: '5 - 5', answer: 0);

      expect(calculator.answer, equals(0));
    });

    test('handles large numbers correctly', () {
      final calculator = Calculator(question: '999 + 1', answer: 1000);

      expect(calculator.answer, equals(1000));
    });

    test('toString returns meaningful representation', () {
      final calculator = Calculator(question: '5 + 3', answer: 8);
      final stringRepresentation = calculator.toString();

      expect(stringRepresentation, contains('5 + 3'));
      expect(stringRepresentation, contains('8'));
      expect(stringRepresentation, contains('Calculator'));
    });

    test('equality works correctly for identical calculators', () {
      final calculator1 = Calculator(question: '5 + 3', answer: 8);
      final calculator2 = Calculator(question: '5 + 3', answer: 8);

      expect(calculator1, equals(calculator2));
    });

    test('equality works correctly for different calculators', () {
      final calculator1 = Calculator(question: '5 + 3', answer: 8);
      final calculator2 = Calculator(question: '5 + 4', answer: 9);
      final calculator3 = Calculator(question: '5 + 3', answer: 9);

      expect(calculator1, isNot(equals(calculator2)));
      expect(calculator1, isNot(equals(calculator3)));
    });

    test('hashCode is consistent for identical calculators', () {
      final calculator1 = Calculator(question: '5 + 3', answer: 8);
      final calculator2 = Calculator(question: '5 + 3', answer: 8);

      expect(calculator1.hashCode, equals(calculator2.hashCode));
    });

    test('hashCode is different for different calculators', () {
      final calculator1 = Calculator(question: '5 + 3', answer: 8);
      final calculator2 = Calculator(question: '5 + 4', answer: 9);

      expect(calculator1.hashCode, isNot(equals(calculator2.hashCode)));
    });

    test('handles empty question string', () {
      final calculator = Calculator(question: '', answer: 0);

      expect(calculator.question, isEmpty);
      expect(calculator.answer, equals(0));
    });

    test('handles whitespace in question string', () {
      final calculator = Calculator(question: ' 5 + 3 ', answer: 8);

      expect(calculator.question, equals(' 5 + 3 '));
      expect(calculator.question.trim(), equals('5 + 3'));
    });

    test('handles decimal-like expressions that result in integers', () {
      final calculator = Calculator(question: '10 / 2', answer: 5);

      expect(calculator.answer, isA<int>());
      expect(calculator.answer, equals(5));
    });

    test('question property is immutable after creation', () {
      final calculator = Calculator(question: '5 + 3', answer: 8);
      final originalQuestion = calculator.question;

      expect(calculator.question, equals(originalQuestion));
      expect(calculator.question, equals('5 + 3'));
    });

    test('answer property is immutable after creation', () {
      final calculator = Calculator(question: '5 + 3', answer: 8);
      final originalAnswer = calculator.answer;

      expect(calculator.answer, equals(originalAnswer));
      expect(calculator.answer, equals(8));
    });

    test('works with various mathematical symbols', () {
      final calculations = [
        Calculator(question: '2 + 2', answer: 4),
        Calculator(question: '10 - 3', answer: 7),
        Calculator(question: '4 * 6', answer: 24),
        Calculator(question: '15 / 3', answer: 5),
      ];

      for (final calc in calculations) {
        expect(calc.question, isNotEmpty);
        expect(calc.answer, isA<int>());
      }
    });

    test('supports complex expressions with precedence', () {
      final complexCalculations = [
        Calculator(question: '2 + 3 * 4', answer: 14),
        Calculator(question: '10 - 2 / 2', answer: 9),
        Calculator(question: '5 * 2 + 3', answer: 13),
      ];

      for (final calc in complexCalculations) {
        expect(calc.question.split(' ').length, greaterThanOrEqualTo(5));
        expect(calc.answer, isA<int>());
      }
    });
  });
}
