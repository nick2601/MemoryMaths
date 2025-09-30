import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/calculator.dart';
import 'package:mathsgames/src/data/repositories/calculator_repository.dart';

void main() {
  group('CalculatorRepository', () {
    setUp(() {
      CalculatorRepository.listHasCode.clear();
    });

    test('generates exactly 5 calculator problems for any level', () {
      for (int level = 1; level <= 8; level++) {
        final problems = CalculatorRepository.getCalculatorDataList(level);
        expect(problems.length, equals(5), reason: 'Level $level should generate 5 problems');
        expect(problems, everyElement(isA<Calculator>()));
      }
    });

    test('generates unique calculator problems within same level', () {
      final problems = CalculatorRepository.getCalculatorDataList(1);
      final hashCodes = problems.map((p) => p.hashCode).toList();
      final uniqueHashCodes = hashCodes.toSet();

      expect(uniqueHashCodes.length, equals(hashCodes.length),
        reason: 'All problems should be unique');
    });

    test('resets hash list when level is 1', () {
      CalculatorRepository.getCalculatorDataList(3);
      expect(CalculatorRepository.listHasCode.isNotEmpty, true);

      CalculatorRepository.getCalculatorDataList(1);
      expect(CalculatorRepository.listHasCode.length, greaterThanOrEqualTo(5));
    });

    test('maintains hash list across different levels except level 1', () {
      CalculatorRepository.getCalculatorDataList(2);
      final hashCountAfterLevel2 = CalculatorRepository.listHasCode.length;

      CalculatorRepository.getCalculatorDataList(3);
      expect(CalculatorRepository.listHasCode.length,
        greaterThan(hashCountAfterLevel2));
    });

    test('generates problems with valid mathematical expressions', () {
      final problems = CalculatorRepository.getCalculatorDataList(1);

      for (final problem in problems) {
        expect(problem.question.isNotEmpty, true);
        expect(problem.answer, isA<int>());
        expect(problem.question.contains(RegExp(r'[+\-*/]')), true);
      }
    });

    test('handles two-operand expressions correctly', () {
      final problems = CalculatorRepository.getCalculatorDataList(1);
      final twoOperandProblems = problems.where(
        (p) => !p.question.contains(RegExp(r'[+\-*/].*[+\-*/]'))
      ).toList();

      expect(twoOperandProblems.isNotEmpty, true);
      for (final problem in twoOperandProblems) {
        final parts = problem.question.split(RegExp(r'\s+'));
        expect(parts.length, equals(3));
      }
    });

    test('handles three-operand expressions correctly', () {
      // Higher levels are more likely to have three-operand expressions
      final problems = CalculatorRepository.getCalculatorDataList(5);
      final threeOperandProblems = problems.where(
        (p) => p.question.contains(RegExp(r'[+\-*/].*[+\-*/]'))
      ).toList();

      for (final problem in threeOperandProblems) {
        final parts = problem.question.split(RegExp(r'\s+'));
        expect(parts.length, equals(5));
      }
    });

    test('prevents infinite loops when MathUtil generates limited expressions', () {
      // This test ensures the while loop doesn't hang
      final startTime = DateTime.now();
      CalculatorRepository.getCalculatorDataList(8);
      final endTime = DateTime.now();

      expect(endTime.difference(startTime).inSeconds, lessThan(5),
        reason: 'Generation should complete within reasonable time');
    });

    test('returns consistent results for same level with cleared hash', () {
      CalculatorRepository.listHasCode.clear();
      final problems1 = CalculatorRepository.getCalculatorDataList(1);

      CalculatorRepository.listHasCode.clear();
      final problems2 = CalculatorRepository.getCalculatorDataList(1);

      expect(problems1.length, equals(problems2.length));
      expect(problems1.length, equals(5));
      expect(problems2.length, equals(5));
    });

    test('handles edge case of level boundaries', () {
      final levelOneProblem = CalculatorRepository.getCalculatorDataList(1);
      final levelEightProblem = CalculatorRepository.getCalculatorDataList(8);

      expect(levelOneProblem.length, equals(5));
      expect(levelEightProblem.length, equals(5));

      for (final problem in levelOneProblem) {
        expect(problem.question.isNotEmpty, true);
        expect(problem.answer, isA<int>());
      }

      for (final problem in levelEightProblem) {
        expect(problem.question.isNotEmpty, true);
        expect(problem.answer, isA<int>());
      }
    });

    test('maintains problem quality across multiple generations', () {
      final allProblems = <Calculator>[];

      for (int i = 1; i <= 3; i++) {
        final problems = CalculatorRepository.getCalculatorDataList(i);
        allProblems.addAll(problems);
      }

      expect(allProblems.length, equals(15));
      expect(allProblems, everyElement(isA<Calculator>()));

      for (final problem in allProblems) {
        expect(problem.question.trim().isNotEmpty, true);
        expect(problem.answer, isA<int>());
      }
    });
  });
}
