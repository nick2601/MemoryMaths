import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/sign.dart';
import 'package:mathsgames/src/data/repositories/sign_repository.dart';

void main() {
  group('SignRepository', () {
    test('generates correct number of sign problems for each level', () {
      for (int level = 1; level <= 8; level++) {
        final problems = SignRepository.getSignDataList(level);
        expect(problems.length, equals(5), reason: 'Level $level should generate 5 problems');
        expect(problems, everyElement(isA<Sign>()));
      }
    });

    test('generates valid sign problems with correct structure', () {
      final problems = SignRepository.getSignDataList(1);

      for (final problem in problems) {
        expect(problem.firstDigit, isNotEmpty);
        expect(problem.secondDigit, isNotEmpty);
        expect(problem.answer, isNotEmpty);
        expect(problem.sign, isNotEmpty);
        expect(['+', '-', '*', '/'].contains(problem.sign), isTrue);
      }
    });

    test('validates sign problem answers are mathematically correct', () {
      final problems = SignRepository.getSignDataList(1);

      for (final problem in problems) {
        final num1 = int.tryParse(problem.firstDigit);
        final num2 = int.tryParse(problem.secondDigit);
        final expectedAnswer = int.tryParse(problem.answer);

        expect(num1, isNotNull);
        expect(num2, isNotNull);
        expect(expectedAnswer, isNotNull);

        int calculatedAnswer;
        switch (problem.sign) {
          case '+':
            calculatedAnswer = num1! + num2!;
            break;
          case '-':
            calculatedAnswer = num1! - num2!;
            break;
          case '*':
            calculatedAnswer = num1! * num2!;
            break;
          case '/':
            calculatedAnswer = num2! != 0 ? num1! ~/ num2 : 0;
            break;
          default:
            calculatedAnswer = 0;
        }

        expect(expectedAnswer, equals(calculatedAnswer),
          reason: 'Problem: ${problem.firstDigit} ${problem.sign} ${problem.secondDigit} should equal ${problem.answer}');
      }
    });

    test('generates problems with appropriate difficulty for different levels', () {
      final level1Problems = SignRepository.getSignDataList(1);
      final level8Problems = SignRepository.getSignDataList(8);

      // Level 1 should have smaller numbers
      for (final problem in level1Problems) {
        final num1 = int.parse(problem.firstDigit);
        final num2 = int.parse(problem.secondDigit);
        expect(num1, lessThanOrEqualTo(20));
        expect(num2, lessThanOrEqualTo(20));
      }

      // Level 8 should have larger numbers
      for (final problem in level8Problems) {
        final num1 = int.parse(problem.firstDigit);
        final num2 = int.parse(problem.secondDigit);
        // At least some numbers should be larger for higher levels
        expect(num1 >= 10 || num2 >= 10, isTrue);
      }
    });

    test('handles division by zero gracefully', () {
      // Generate many problems to try to catch division by zero
      for (int level = 1; level <= 8; level++) {
        final problems = SignRepository.getSignDataList(level);

        for (final problem in problems) {
          if (problem.sign == '/') {
            final num2 = int.parse(problem.secondDigit);
            expect(num2, isNot(equals(0)),
              reason: 'Division by zero should not occur');
          }
        }
      }
    });

    test('generates unique problems within reasonable attempts', () {
      final problems = SignRepository.getSignDataList(3);
      final problemStrings = problems.map((p) =>
        '${p.firstDigit} ${p.sign} ${p.secondDigit} = ${p.answer}').toList();

      // Check that most problems are unique (allowing some duplicates due to randomness)
      final uniqueProblems = problemStrings.toSet();
      expect(uniqueProblems.length, greaterThanOrEqualTo(3),
        reason: 'Should generate reasonably unique problems');
    });
  });

  group('Sign Model', () {
    test('creates sign instance with valid properties', () {
      final sign = Sign(
        firstDigit: '5',
        secondDigit: '3',
        sign: '+',
        answer: '8',
      );

      expect(sign.firstDigit, equals('5'));
      expect(sign.secondDigit, equals('3'));
      expect(sign.sign, equals('+'));
      expect(sign.answer, equals('8'));
    });

    test('handles all arithmetic operators', () {
      final operators = ['+', '-', '*', '/'];

      for (final op in operators) {
        final sign = Sign(
          firstDigit: '10',
          secondDigit: '2',
          sign: op,
          answer: '5',
        );

        expect(sign.sign, equals(op));
        expect(['+', '-', '*', '/'].contains(sign.sign), isTrue);
      }
    });

    test('handles single and multi-digit numbers', () {
      final testCases = [
        {'first': '1', 'second': '2'},
        {'first': '10', 'second': '20'},
        {'first': '100', 'second': '5'},
        {'first': '7', 'second': '123'},
      ];

      for (final testCase in testCases) {
        final sign = Sign(
          firstDigit: testCase['first']!,
          secondDigit: testCase['second']!,
          sign: '+',
          answer: '0',
        );

        expect(sign.firstDigit, equals(testCase['first']));
        expect(sign.secondDigit, equals(testCase['second']));
      }
    });

    test('handles negative answers', () {
      final sign = Sign(
        firstDigit: '3',
        secondDigit: '8',
        sign: '-',
        answer: '-5',
      );

      expect(sign.answer, equals('-5'));
      expect(sign.answer.startsWith('-'), isTrue);
    });

    test('handles zero values', () {
      final testCases = [
        Sign(firstDigit: '0', secondDigit: '5', sign: '+', answer: '5'),
        Sign(firstDigit: '5', secondDigit: '0', sign: '+', answer: '5'),
        Sign(firstDigit: '5', secondDigit: '5', sign: '-', answer: '0'),
      ];

      for (final sign in testCases) {
        expect(sign.firstDigit, isNotNull);
        expect(sign.secondDigit, isNotNull);
        expect(sign.answer, isNotNull);
      }
    });
  });
}
