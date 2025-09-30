import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/core/app_constant.dart';

void main() {
  group('GameCategoryType', () {
    test('contains all expected game types', () {
      final expectedTypes = [
        GameCategoryType.CALCULATOR,
        GameCategoryType.GUESS_SIGN,
        GameCategoryType.SQUARE_ROOT,
        GameCategoryType.MATH_PAIRS,
        GameCategoryType.CORRECT_ANSWER,
        GameCategoryType.MAGIC_TRIANGLE,
        GameCategoryType.MENTAL_ARITHMETIC,
        GameCategoryType.QUICK_CALCULATION,
        GameCategoryType.FIND_MISSING,
        GameCategoryType.TRUE_FALSE,
        GameCategoryType.MATH_GRID,
        GameCategoryType.PICTURE_PUZZLE,
        GameCategoryType.NUMBER_PYRAMID,
        GameCategoryType.DUAL_GAME,
        GameCategoryType.COMPLEX_CALCULATION,
        GameCategoryType.CUBE_ROOT,
        GameCategoryType.CONCENTRATION,
        GameCategoryType.NUMERIC_MEMORY,
      ];

      expect(GameCategoryType.values.length, equals(expectedTypes.length));
      for (final type in expectedTypes) {
        expect(GameCategoryType.values, contains(type));
      }
    });

    test('enum values have consistent naming', () {
      for (final type in GameCategoryType.values) {
        expect(type.toString(), contains('GameCategoryType.'));
        expect(type.toString().split('.').last, isNotEmpty);
      }
    });
  });

  group('DialogType', () {
    test('contains all expected dialog types', () {
      final expectedTypes = [
        DialogType.non,
        DialogType.info,
        DialogType.over,
        DialogType.pause,
        DialogType.exit,
        DialogType.hint,
      ];

      expect(DialogType.values.length, equals(expectedTypes.length));
      for (final type in expectedTypes) {
        expect(DialogType.values, contains(type));
      }
    });

    test('has non as default state', () {
      expect(DialogType.non, isA<DialogType>());
      expect(DialogType.values.first, equals(DialogType.non));
    });
  });

  group('TimerStatus', () {
    test('contains all expected timer states', () {
      final expectedStates = [
        TimerStatus.restart,
        TimerStatus.play,
        TimerStatus.pause,
      ];

      expect(TimerStatus.values.length, equals(expectedStates.length));
      for (final state in expectedStates) {
        expect(TimerStatus.values, contains(state));
      }
    });

    test('has restart as default state', () {
      expect(TimerStatus.restart, isA<TimerStatus>());
      expect(TimerStatus.values.first, equals(TimerStatus.restart));
    });
  });

  group('PuzzleType', () {
    test('contains all expected puzzle types', () {
      final expectedTypes = [
        PuzzleType.MATH_PUZZLE,
        PuzzleType.MEMORY_PUZZLE,
        PuzzleType.BRAIN_PUZZLE,
      ];

      expect(PuzzleType.values.length, equals(expectedTypes.length));
      for (final type in expectedTypes) {
        expect(PuzzleType.values, contains(type));
      }
    });
  });

  group('KeyUtil', () {
    test('returns correct score multipliers for different game types', () {
      final scoreTests = {
        GameCategoryType.CALCULATOR: 1.0,
        GameCategoryType.GUESS_SIGN: 1.0,
        GameCategoryType.SQUARE_ROOT: 1.0,
        GameCategoryType.CUBE_ROOT: 1.0,
        GameCategoryType.CORRECT_ANSWER: 1.0,
        GameCategoryType.QUICK_CALCULATION: 1.0,
        GameCategoryType.FIND_MISSING: 1.0,
        GameCategoryType.TRUE_FALSE: 1.0,
        GameCategoryType.MENTAL_ARITHMETIC: 2.0,
        GameCategoryType.MATH_PAIRS: 5.0,
        GameCategoryType.CONCENTRATION: 5.0,
        GameCategoryType.MAGIC_TRIANGLE: 5.0,
        GameCategoryType.PICTURE_PUZZLE: 2.0,
        GameCategoryType.NUMBER_PYRAMID: 5.0,
        GameCategoryType.NUMERIC_MEMORY: 1.0,
        GameCategoryType.DUAL_GAME: 1.0,
        GameCategoryType.COMPLEX_CALCULATION: 1.0,
        GameCategoryType.MATH_GRID: 5.0,
      };

      for (final entry in scoreTests.entries) {
        expect(KeyUtil.getScoreUtil(entry.key), equals(entry.value));
      }
    });

    test('returns correct penalty scores for different game types', () {
      final penaltyTests = {
        GameCategoryType.CALCULATOR: -1.0,
        GameCategoryType.GUESS_SIGN: -1.0,
        GameCategoryType.SQUARE_ROOT: -1.0,
        GameCategoryType.CUBE_ROOT: -1.0,
        GameCategoryType.CORRECT_ANSWER: -1.0,
        GameCategoryType.QUICK_CALCULATION: -1.0,
        GameCategoryType.FIND_MISSING: -1.0,
        GameCategoryType.TRUE_FALSE: -1.0,
        GameCategoryType.MENTAL_ARITHMETIC: -1.0,
        GameCategoryType.MATH_PAIRS: -5.0,
        GameCategoryType.CONCENTRATION: 0.0,
        GameCategoryType.MAGIC_TRIANGLE: 0.0,
        GameCategoryType.PICTURE_PUZZLE: -1.0,
        GameCategoryType.NUMBER_PYRAMID: 0.0,
        GameCategoryType.NUMERIC_MEMORY: -1.0,
        GameCategoryType.DUAL_GAME: -1.0,
        GameCategoryType.COMPLEX_CALCULATION: -1.0,
        GameCategoryType.MATH_GRID: 0.0,
      };

      for (final entry in penaltyTests.entries) {
        expect(KeyUtil.getScoreMinusUtil(entry.key), equals(entry.value));
      }
    });

    test('returns correct time limits for different game types', () {
      final timeTests = {
        GameCategoryType.CALCULATOR: 20,
        GameCategoryType.GUESS_SIGN: 20,
        GameCategoryType.SQUARE_ROOT: 15,
        GameCategoryType.CUBE_ROOT: 15,
        GameCategoryType.CORRECT_ANSWER: 20,
        GameCategoryType.QUICK_CALCULATION: 20,
        GameCategoryType.FIND_MISSING: 20,
        GameCategoryType.TRUE_FALSE: 20,
        GameCategoryType.MENTAL_ARITHMETIC: 60,
        GameCategoryType.MATH_PAIRS: 60,
        GameCategoryType.CONCENTRATION: 15,
        GameCategoryType.MAGIC_TRIANGLE: 60,
        GameCategoryType.PICTURE_PUZZLE: 90,
        GameCategoryType.NUMBER_PYRAMID: 120,
        GameCategoryType.NUMERIC_MEMORY: 5,
        GameCategoryType.DUAL_GAME: 20,
        GameCategoryType.COMPLEX_CALCULATION: 20,
        GameCategoryType.MATH_GRID: 120,
      };

      for (final entry in timeTests.entries) {
        expect(KeyUtil.getTimeUtil(entry.key), equals(entry.value));
      }
    });

    test('returns correct coin rewards for different game types', () {
      final coinTests = {
        GameCategoryType.CALCULATOR: 0.5,
        GameCategoryType.GUESS_SIGN: 0.5,
        GameCategoryType.SQUARE_ROOT: 0.5,
        GameCategoryType.CUBE_ROOT: 0.5,
        GameCategoryType.CORRECT_ANSWER: 0.5,
        GameCategoryType.QUICK_CALCULATION: 0.5,
        GameCategoryType.FIND_MISSING: 1.0,
        GameCategoryType.TRUE_FALSE: 1.0,
        GameCategoryType.MENTAL_ARITHMETIC: 1.0,
        GameCategoryType.MATH_PAIRS: 1.0,
        GameCategoryType.CONCENTRATION: 1.0,
        GameCategoryType.MAGIC_TRIANGLE: 3.0,
        GameCategoryType.PICTURE_PUZZLE: 1.0,
        GameCategoryType.NUMBER_PYRAMID: 3.0,
        GameCategoryType.NUMERIC_MEMORY: 1.0,
        GameCategoryType.DUAL_GAME: 1.0,
        GameCategoryType.COMPLEX_CALCULATION: 1.0,
        GameCategoryType.MATH_GRID: 3.0,
      };

      for (final entry in coinTests.entries) {
        expect(KeyUtil.getCoinUtil(entry.key), equals(entry.value));
      }
    });

    test('time limits are all positive and reasonable', () {
      for (final gameType in GameCategoryType.values) {
        final timeLimit = KeyUtil.getTimeUtil(gameType);
        expect(timeLimit, greaterThan(0));
        expect(timeLimit, lessThanOrEqualTo(180)); // Max 3 minutes
        expect(timeLimit, greaterThanOrEqualTo(5)); // Min 5 seconds
      }
    });

    test('positive scores are always positive or zero', () {
      for (final gameType in GameCategoryType.values) {
        expect(KeyUtil.getScoreUtil(gameType), greaterThanOrEqualTo(0));
      }
    });

    test('coin rewards are positive', () {
      for (final gameType in GameCategoryType.values) {
        expect(KeyUtil.getCoinUtil(gameType), greaterThan(0));
      }
    });

    test('difficulty-based games have appropriate time limits', () {
      // Quick games should have shorter time limits
      final quickGames = [
        GameCategoryType.CALCULATOR,
        GameCategoryType.GUESS_SIGN,
        GameCategoryType.CORRECT_ANSWER,
        GameCategoryType.QUICK_CALCULATION,
        GameCategoryType.FIND_MISSING,
        GameCategoryType.TRUE_FALSE,
        GameCategoryType.DUAL_GAME,
        GameCategoryType.COMPLEX_CALCULATION,
      ];

      for (final game in quickGames) {
        expect(KeyUtil.getTimeUtil(game), lessThanOrEqualTo(20));
      }

      // Complex games should have longer time limits
      final complexGames = [
        GameCategoryType.MATH_GRID,
        GameCategoryType.NUMBER_PYRAMID,
      ];

      for (final game in complexGames) {
        expect(KeyUtil.getTimeUtil(game), greaterThanOrEqualTo(120));
      }
    });
  });

  group('Constants Integration', () {
    test('all game types have corresponding utilities', () {
      for (final gameType in GameCategoryType.values) {
        expect(() => KeyUtil.getScoreUtil(gameType), returnsNormally);
        expect(() => KeyUtil.getScoreMinusUtil(gameType), returnsNormally);
        expect(() => KeyUtil.getTimeUtil(gameType), returnsNormally);
        expect(() => KeyUtil.getCoinUtil(gameType), returnsNormally);
      }
    });

    test('dashboard items are properly configured', () {
      expect(KeyUtil.dashboardItems.length, equals(3));

      for (final dashboard in KeyUtil.dashboardItems) {
        expect(dashboard.title, isNotEmpty);
        expect(dashboard.subtitle, isNotEmpty);
        expect(dashboard.folder, isNotEmpty);
        expect(dashboard.position, greaterThanOrEqualTo(0));
      }
    });

    test('background colors list matches dashboard items', () {
      expect(KeyUtil.bgColorList.length, equals(3));
      expect(KeyUtil.bgColorList.length, equals(KeyUtil.dashboardItems.length));
    });

    test('route constants are properly defined', () {
      final routes = [
        KeyUtil.splash,
        KeyUtil.dashboard,
        KeyUtil.home,
        KeyUtil.calculator,
        KeyUtil.guessSign,
        KeyUtil.squareRoot,
        KeyUtil.magicTriangle,
      ];

      for (final route in routes) {
        expect(route, isNotEmpty);
        expect(route, isA<String>());
      }
    });

    test('game scoring is balanced', () {
      // Games with higher difficulty should have higher rewards
      final complexGames = [
        GameCategoryType.MAGIC_TRIANGLE,
        GameCategoryType.MATH_GRID,
        GameCategoryType.NUMBER_PYRAMID,
      ];

      for (final game in complexGames) {
        expect(KeyUtil.getScoreUtil(game), greaterThanOrEqualTo(3.0));
        expect(KeyUtil.getCoinUtil(game), greaterThanOrEqualTo(3.0));
      }
    });
  });
}
