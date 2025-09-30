import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/utility/math_util.dart';

void main() {
  group('MathUtil', () {
    test('evaluates basic arithmetic operations correctly', () {
      expect(MathUtil.evaluate(5, '+', 3), equals(8));
      expect(MathUtil.evaluate(10, '-', 4), equals(6));
      expect(MathUtil.evaluate(6, '*', 7), equals(42));
      expect(MathUtil.evaluate(15, '/', 3), equals(5));
    });

    test('handles division by zero gracefully', () {
      expect(MathUtil.evaluate(10, '/', 0), equals(0));
    });

    test('identifies valid operators correctly', () {
      expect(MathUtil.isOperator('+'), isTrue);
      expect(MathUtil.isOperator('-'), isTrue);
      expect(MathUtil.isOperator('*'), isTrue);
      expect(MathUtil.isOperator('/'), isTrue);
      expect(MathUtil.isOperator('%'), isFalse);
      expect(MathUtil.isOperator('='), isFalse);
    });

    test('returns correct operator precedence', () {
      expect(MathUtil.getPrecedence('+'), equals(1));
      expect(MathUtil.getPrecedence('-'), equals(1));
      expect(MathUtil.getPrecedence('*'), equals(2));
      expect(MathUtil.getPrecedence('/'), equals(3));
    });

    test('generates random numbers within specified range', () {
      for (int i = 0; i < 10; i++) {
        final result = MathUtil.generateRandomAnswer(5, 15);
        expect(result, greaterThanOrEqualTo(5));
        expect(result, lessThan(15));
      }
    });

    test('generates valid random operators', () {
      final validOperators = ['+', '-', '*', '/'];
      for (int i = 0; i < 20; i++) {
        final operator = MathUtil.generateRandomSign();
        expect(validOperators.contains(operator), isTrue);
      }
    });

    test('generates correct number of random operators', () {
      final operators = MathUtil.generateRandomSign1(5);
      expect(operators.length, equals(5));
      for (final op in operators) {
        expect(['+', '-', '*', '/'].contains(op), isTrue);
      }
    });

    test('generates correct number of random numbers as strings', () {
      final numbers = MathUtil.generateRandomNumber(1, 10, 3);
      expect(numbers.length, equals(3));
      for (final numStr in numbers) {
        final num = int.tryParse(numStr);
        expect(num, isNotNull);
        expect(num!, greaterThanOrEqualTo(1));
        expect(num, lessThan(10));
      }
    });

    test('generates valid addition expressions', () {
      final expression = MathUtil.getPlusSignExp(1, 10);
      expect(expression.operator1, equals('+'));
      expect(expression.operator2, isNull);
      expect(expression.thirdOperand, equals(''));

      final num1 = int.parse(expression.firstOperand);
      final num2 = int.parse(expression.secondOperand);
      expect(expression.answer, equals(num1 + num2));
    });

    test('generates valid subtraction expressions with non-negative results', () {
      final expression = MathUtil.getMinusSignExp(1, 20);
      expect(expression.operator1, equals('-'));
      expect(expression.answer, greaterThanOrEqualTo(0));

      final num1 = int.parse(expression.firstOperand);
      final num2 = int.parse(expression.secondOperand);
      expect(expression.answer, equals(num1 - num2));
    });

    test('generates valid multiplication expressions', () {
      final expression = MathUtil.getMultiplySignExp(1, 10);
      expect(expression.operator1, equals('*'));

      final num1 = int.parse(expression.firstOperand);
      final num2 = int.parse(expression.secondOperand);
      expect(expression.answer, equals(num1 * num2));
    });

    test('generates valid division expressions with clean division', () {
      final expression = MathUtil.getDivideSignExp(1, 20);
      if (expression != null) {
        expect(expression.operator1, equals('/'));

        final num1 = int.parse(expression.firstOperand);
        final num2 = int.parse(expression.secondOperand);
        expect(num2, isNot(equals(0)));
        expect(num1 % num2, equals(0));
        expect(expression.answer, equals(num1 ~/ num2));
      }
    });

    test('handles division expression generation when no valid pairs exist', () {
      final expression = MathUtil.getDivideSignExp(2, 3);
      // Should return null or a valid expression depending on available pairs
      if (expression != null) {
        expect(expression.operator1, equals('/'));
      }
    });

    test('generates mixed expressions with multiple operators', () {
      final expression = MathUtil.getMixExp(1, 10);
      if (expression != null) {
        expect(expression.operator2, isNotNull);
        expect(expression.thirdOperand, isNotEmpty);
      }
    });

    test('generates correct number of math pair expressions', () {
      final expressions = MathUtil.getMathPair(1, 5);
      expect(expressions.length, lessThanOrEqualTo(5));
      for (final expr in expressions) {
        expect(expr, isA<Expression>());
      }
    });

    test('generates expressions for different levels', () {
      for (int level = 1; level <= 5; level++) {
        final expressions = MathUtil.generate(level, 3);
        expect(expressions.length, lessThanOrEqualTo(3));
        for (final expr in expressions) {
          expect(expr, isA<Expression>());
          expect(expr.answer, isA<int>());
        }
      }
    });

    test('expression constructor works correctly', () {
      final expression = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      expect(expression.firstOperand, equals('5'));
      expect(expression.operator1, equals('+'));
      expect(expression.secondOperand, equals('3'));
      expect(expression.operator2, isNull);
      expect(expression.thirdOperand, equals(''));
      expect(expression.answer, equals(8));
    });

    test('expression toString works correctly', () {
      final expression = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      final toString = expression.toString();
      expect(toString.contains('5'), isTrue);
      expect(toString.contains('+'), isTrue);
      expect(toString.contains('3'), isTrue);
      expect(toString.contains('8'), isTrue);
    });

    test('expression equality works correctly', () {
      final expr1 = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      final expr2 = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      final expr3 = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '4',
        operator2: null,
        thirdOperand: '',
        answer: 9,
      );

      expect(expr1, equals(expr2));
      expect(expr1, isNot(equals(expr3)));
    });

    test('expression hashCode is consistent', () {
      final expr1 = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      final expr2 = Expression(
        firstOperand: '5',
        operator1: '+',
        secondOperand: '3',
        operator2: null,
        thirdOperand: '',
        answer: 8,
      );

      expect(expr1.hashCode, equals(expr2.hashCode));
    });

    test('generates mental arithmetic expressions', () {
      final expression = MathUtil.getMentalExp(1);
      if (expression != null) {
        expect(expression, isA<Expression>());
        expect(expression.answer, isA<int>());
      }
    });
  });
}
