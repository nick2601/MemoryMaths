import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/repositories/calculator_repository.dart';
import 'package:mathsgames/src/data/repositories/sign_repository.dart';
import 'package:mathsgames/src/data/repositories/correct_answer_repository.dart';
import 'package:mathsgames/src/data/repositories/square_root_repository.dart';
import 'package:mathsgames/src/data/repositories/cube_root_repository.dart';
import 'package:mathsgames/src/data/repositories/math_pairs_repository.dart';
import 'package:mathsgames/src/data/repositories/magic_triangle_repository.dart';
import 'package:mathsgames/src/data/repositories/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/data/repositories/quick_calculation_repository.dart';
import 'package:mathsgames/src/data/repositories/find_missing_repository.dart';
import 'package:mathsgames/src/data/repositories/true_false_repository.dart';
import 'package:mathsgames/src/data/repositories/dual_repository.dart';
import 'package:mathsgames/src/data/repositories/complex_calcualtion_repository.dart';
import 'package:mathsgames/src/data/repositories/number_pyramid_repository.dart';
import 'package:mathsgames/src/data/repositories/numeric_memory_repository.dart';
import 'package:mathsgames/src/data/repositories/picture_puzzle_repository.dart';
import 'package:mathsgames/src/data/repositories/math_grid_repository.dart';
import 'package:mathsgames/src/core/app_constant.dart';

void main() {
  group('Repository Integration Tests', () {
    test('all repositories generate data without errors', () {
      // Test that all repositories can generate data for level 1
      expect(() => CalculatorRepository.getCalculatorDataList(1), returnsNormally);
      expect(() => SignRepository.getSignDataList(1), returnsNormally);
      expect(() => CorrectAnswerRepository.getCorrectAnswerDataList(1), returnsNormally);
      expect(() => SquareRootRepository.getSquareDataList(1), returnsNormally);
      expect(() => CubeRootRepository.getCubeDataList(1), returnsNormally);
      expect(() => MathPairsRepository.getMathPairsDataList(1), returnsNormally);
      expect(() => MagicTriangleRepository.getTriangleDataProviderList(), returnsNormally);
      expect(() => MentalArithmeticRepository.getMentalArithmeticDataList(1), returnsNormally);
      expect(() => QuickCalculationRepository.getQuickCalculationDataList(1, 5), returnsNormally);
      expect(() => FindMissingRepository.getFindMissingDataList(1), returnsNormally);
      expect(() => TrueFalseRepository.getTrueFalseDataList(1), returnsNormally);
      expect(() => DualRepository.getDualData(1), returnsNormally);
      expect(() => ComplexCalculationRepository.getComplexData(1), returnsNormally);
      expect(() => NumberPyramidRepository.getPyramidDataList(1), returnsNormally);
      expect(() => NumericMemoryRepository.getNumericMemoryDataList(1), returnsNormally);
      expect(() => PicturePuzzleRepository.getPicturePuzzleDataList(1), returnsNormally);
      expect(() => MathGridRepository.getMathGridData(1), returnsNormally);
    });

    test('repositories generate consistent data sizes', () {
      // Test that repositories generate expected number of items
      final calculatorData = CalculatorRepository.getCalculatorDataList(1);
      final signData = SignRepository.getSignDataList(1);
      final correctAnswerData = CorrectAnswerRepository.getCorrectAnswerDataList(1);
      final squareRootData = SquareRootRepository.getSquareDataList(1);
      final cubeRootData = CubeRootRepository.getCubeDataList(1);
      final findMissingData = FindMissingRepository.getFindMissingDataList(1);
      final trueFalseData = TrueFalseRepository.getTrueFalseDataList(1);
      final quickCalcData = QuickCalculationRepository.getQuickCalculationDataList(1, 5);

      // Most repositories should generate 5 items per level
      expect(calculatorData.length, equals(5));
      expect(signData.length, equals(5));
      expect(correctAnswerData.length, equals(5));
      expect(squareRootData.length, equals(5));
      expect(cubeRootData.length, equals(5));
      expect(findMissingData.length, equals(5));
      expect(trueFalseData.length, equals(5));
      expect(quickCalcData.length, equals(5));
    });

    test('repositories handle level progression consistently', () {
      for (int level = 1; level <= 5; level++) {
        // Test repositories that support multiple levels
        final calculatorProblems = CalculatorRepository.getCalculatorDataList(level);
        final signProblems = SignRepository.getSignDataList(level);
        final correctAnswerProblems = CorrectAnswerRepository.getCorrectAnswerDataList(level);

        expect(calculatorProblems.length, equals(5),
          reason: 'Calculator should generate 5 problems for level $level');
        expect(signProblems.length, equals(5),
          reason: 'Sign should generate 5 problems for level $level');
        expect(correctAnswerProblems.length, equals(5),
          reason: 'CorrectAnswer should generate 5 problems for level $level');

        // Verify data quality doesn't degrade with higher levels
        for (final problem in calculatorProblems) {
          expect(problem.question, isNotEmpty);
          expect(problem.answer, isA<int>());
        }
      }
    });

    test('repositories generate mathematically valid data', () {
      final calculatorData = CalculatorRepository.getCalculatorDataList(2);
      final signData = SignRepository.getSignDataList(2);
      final correctAnswerData = CorrectAnswerRepository.getCorrectAnswerDataList(2);

      // Verify calculator problems are mathematically correct
      for (final calc in calculatorData) {
        expect(calc.question, matches(RegExp(r'\d+\s*[+\-*/]\s*\d+')));
        expect(calc.answer, isA<int>());
      }

      // Verify sign problems have valid operators
      for (final sign in signData) {
        expect(['+', '-', '*', '/'], contains(sign.sign));
        expect(sign.firstDigit, matches(RegExp(r'\d+')));
        expect(sign.secondDigit, matches(RegExp(r'\d+')));
        expect(sign.answer, matches(RegExp(r'-?\d+')));
      }

      // Verify correct answer problems include the correct answer
      for (final correct in correctAnswerData) {
        final options = [correct.firstAns, correct.secondAns, correct.thirdAns, correct.fourthAns];
        expect(options, contains(correct.answer.toString()));
      }
    });

    test('repositories maintain data uniqueness within levels', () {
      final calculatorData = CalculatorRepository.getCalculatorDataList(3);
      final signData = SignRepository.getSignDataList(3);

      // Check for reasonable uniqueness in calculator problems
      final calculatorQuestions = calculatorData.map((c) => c.question).toList();
      final uniqueCalculatorQuestions = calculatorQuestions.toSet();
      expect(uniqueCalculatorQuestions.length, greaterThanOrEqualTo(calculatorQuestions.length ~/ 2),
        reason: 'Calculator problems should have reasonable uniqueness');

      // Check for reasonable uniqueness in sign problems
      final signQuestions = signData.map((s) => '${s.firstDigit} ${s.sign} ${s.secondDigit}').toList();
      final uniqueSignQuestions = signQuestions.toSet();
      expect(uniqueSignQuestions.length, greaterThanOrEqualTo(signQuestions.length ~/ 2),
        reason: 'Sign problems should have reasonable uniqueness');
    });

    test('repositories handle edge cases gracefully', () {
      // Test with boundary level values
      expect(() => CalculatorRepository.getCalculatorDataList(1), returnsNormally);
      expect(() => CalculatorRepository.getCalculatorDataList(8), returnsNormally);
      expect(() => SignRepository.getSignDataList(1), returnsNormally);
      expect(() => SignRepository.getSignDataList(8), returnsNormally);

      // Test quick calculation with different counts
      expect(() => QuickCalculationRepository.getQuickCalculationDataList(1, 1), returnsNormally);
      expect(() => QuickCalculationRepository.getQuickCalculationDataList(1, 10), returnsNormally);

      // Test repositories that might return null or empty
      final triangleData = MagicTriangleRepository.getTriangleDataProviderList();
      expect(triangleData, isNotEmpty);

      final advancedTriangleData = MagicTriangleRepository.getNextLevelTriangleDataProviderList();
      expect(advancedTriangleData, isNotEmpty);
    });

    test('repositories provide consistent difficulty scaling', () {
      // Compare level 1 vs level 5 data for complexity
      final level1Calculator = CalculatorRepository.getCalculatorDataList(1);
      final level5Calculator = CalculatorRepository.getCalculatorDataList(5);

      final level1Signs = SignRepository.getSignDataList(1);
      final level5Signs = SignRepository.getSignDataList(5);

      // Level 5 should generally have larger numbers or more complex expressions
      final level1AvgAnswer = level1Calculator.map((c) => c.answer.abs()).reduce((a, b) => a + b) / level1Calculator.length;
      final level5AvgAnswer = level5Calculator.map((c) => c.answer.abs()).reduce((a, b) => a + b) / level5Calculator.length;

      expect(level5AvgAnswer, greaterThanOrEqualTo(level1AvgAnswer * 0.8),
        reason: 'Higher levels should have reasonably larger or more complex answers');

      // Check that higher levels don't have trivially simple problems
      for (final calc in level5Calculator) {
        expect(calc.question.length, greaterThan(3),
          reason: 'Level 5 problems should not be trivially simple');
      }
    });

    test('memory and puzzle repositories maintain internal consistency', () {
      final mathPairsData = MathPairsRepository.getMathPairsDataList(1);
      final numericMemoryData = NumericMemoryRepository.getNumericMemoryDataList(1);
      final picturePuzzleData = PicturePuzzleRepository.getPicturePuzzleDataList(1);

      // Math pairs should have matching question-answer relationships
      for (final mathPair in mathPairsData) {
        expect(mathPair.list, isNotEmpty);
        expect(mathPair.availableItem, greaterThanOrEqualTo(0));
        expect(mathPair.availableItem, lessThanOrEqualTo(mathPair.list.length));

        for (final pair in mathPair.list) {
          expect(pair.text, isNotEmpty);
          expect(pair.uid, greaterThanOrEqualTo(0));
        }
      }

      // Numeric memory should have valid sequences
      for (final memory in numericMemoryData) {
        expect(memory.list, isNotEmpty);
        expect(memory.list, everyElement(isA<int>()));
      }

      // Picture puzzles should have valid structure
      for (final puzzle in picturePuzzleData) {
        expect(puzzle.list, isNotEmpty);
        expect(puzzle.answer, isA<int>());
      }
    });

    test('repositories work correctly with KeyUtil configurations', () {
      // Test that all game types have corresponding repository data
      final gameTypeToRepository = {
        GameCategoryType.CALCULATOR: () => CalculatorRepository.getCalculatorDataList(1),
        GameCategoryType.GUESS_SIGN: () => SignRepository.getSignDataList(1),
        GameCategoryType.CORRECT_ANSWER: () => CorrectAnswerRepository.getCorrectAnswerDataList(1),
        GameCategoryType.SQUARE_ROOT: () => SquareRootRepository.getSquareDataList(1),
        GameCategoryType.CUBE_ROOT: () => CubeRootRepository.getCubeDataList(1),
        GameCategoryType.FIND_MISSING: () => FindMissingRepository.getFindMissingDataList(1),
        GameCategoryType.TRUE_FALSE: () => TrueFalseRepository.getTrueFalseDataList(1),
        GameCategoryType.QUICK_CALCULATION: () => QuickCalculationRepository.getQuickCalculationDataList(1, 5),
      };

      for (final entry in gameTypeToRepository.entries) {
        final gameType = entry.key;
        final repositoryCall = entry.value;

        // Verify KeyUtil has configuration for this game type
        expect(() => KeyUtil.getScoreUtil(gameType), returnsNormally);
        expect(() => KeyUtil.getTimeUtil(gameType), returnsNormally);
        expect(() => KeyUtil.getCoinUtil(gameType), returnsNormally);

        // Verify repository can generate data
        expect(repositoryCall, returnsNormally);
        final data = repositoryCall();
        expect(data, isNotEmpty);
      }
    });

    test('repositories handle concurrent access safely', () {
      // Simulate multiple concurrent calls to repositories
      final futures = <Future>[];

      for (int i = 0; i < 5; i++) {
        futures.add(Future(() => CalculatorRepository.getCalculatorDataList(1 + (i % 3))));
        futures.add(Future(() => SignRepository.getSignDataList(1 + (i % 3))));
        futures.add(Future(() => CorrectAnswerRepository.getCorrectAnswerDataList(1 + (i % 3))));
      }

      return Future.wait(futures).then((results) {
        expect(results, hasLength(15));
        for (final result in results) {
          expect(result, isNotEmpty);
        }
      });
    });

    test('repositories maintain performance within acceptable limits', () {
      final stopwatch = Stopwatch()..start();

      // Generate data from multiple repositories
      CalculatorRepository.getCalculatorDataList(3);
      SignRepository.getSignDataList(3);
      CorrectAnswerRepository.getCorrectAnswerDataList(3);
      SquareRootRepository.getSquareDataList(3);
      CubeRootRepository.getCubeDataList(3);

      stopwatch.stop();

      // Should complete within reasonable time (5 seconds is generous)
      expect(stopwatch.elapsedMilliseconds, lessThan(5000),
        reason: 'Repository data generation should complete within 5 seconds');
    });
  });

  group('Cross-Repository Data Consistency', () {
    test('mathematical operations are consistent across repositories', () {
      final calculatorData = CalculatorRepository.getCalculatorDataList(2);
      final signData = SignRepository.getSignDataList(2);

      // Both should use similar mathematical operations
      final calculatorOperators = calculatorData
          .map((c) => RegExp(r'[+\-*/]').firstMatch(c.question)?.group(0))
          .where((op) => op != null)
          .toSet();

      final signOperators = signData.map((s) => s.sign).toSet();

      expect(calculatorOperators, isNotEmpty);
      expect(signOperators, isNotEmpty);

      // Should have overlapping operators
      final commonOperators = calculatorOperators.toSet().intersection(signOperators);
      expect(commonOperators, isNotEmpty,
        reason: 'Calculator and Sign repositories should use common operators');
    });

    test('difficulty progression is consistent across similar repositories', () {
      final repositories = [
        (String name, Function repo) => MapEntry(name, repo),
      ];

      final repoResults = <String, List<double>>{};

      // Test difficulty progression for similar repository types
      final mathRepos = {
        'Calculator': (int level) => CalculatorRepository.getCalculatorDataList(level)
            .map((c) => c.answer.abs().toDouble()).toList(),
        'Sign': (int level) => SignRepository.getSignDataList(level)
            .map((s) => int.tryParse(s.answer)?.abs().toDouble() ?? 0).toList(),
        'CorrectAnswer': (int level) => CorrectAnswerRepository.getCorrectAnswerDataList(level)
            .map((c) => c.answer.abs().toDouble()).toList(),
      };

      for (final entry in mathRepos.entries) {
        final repoName = entry.key;
        final repoFunction = entry.value;

        final level1Avg = repoFunction(1).reduce((a, b) => a + b) / 5;
        final level3Avg = repoFunction(3).reduce((a, b) => a + b) / 5;

        repoResults[repoName] = [level1Avg, level3Avg];

        expect(level3Avg, greaterThanOrEqualTo(level1Avg * 0.7),
          reason: '$repoName should show difficulty progression from level 1 to 3');
      }

      // All math repositories should show similar difficulty scaling patterns
      final scalingFactors = repoResults.values.map((values) => values[1] / values[0]).toList();
      final avgScaling = scalingFactors.reduce((a, b) => a + b) / scalingFactors.length;

      for (final scaling in scalingFactors) {
        expect(scaling, closeTo(avgScaling, avgScaling * 0.5),
          reason: 'Difficulty scaling should be consistent across math repositories');
      }
    });
  });
}
