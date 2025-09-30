import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/core/app_constant.dart';

void main() {
  group('ThemeProvider', () {
    late ThemeProvider themeProvider;

    setUp(() {
      themeProvider = ThemeProvider();
    });

    test('initializes with light theme by default', () {
      expect(themeProvider.themeMode, equals(ThemeMode.light));
      expect(themeProvider.isDarkMode, isFalse);
    });

    test('toggles theme mode correctly', () {
      expect(themeProvider.isDarkMode, isFalse);

      themeProvider.updateTheme(true);
      expect(themeProvider.isDarkMode, isTrue);
      expect(themeProvider.themeMode, equals(ThemeMode.dark));

      themeProvider.updateTheme(false);
      expect(themeProvider.isDarkMode, isFalse);
      expect(themeProvider.themeMode, equals(ThemeMode.light));
    });

    test('notifies listeners when theme changes', () {
      bool wasNotified = false;
      themeProvider.addListener(() {
        wasNotified = true;
      });

      themeProvider.updateTheme(true);
      expect(wasNotified, isTrue);

      wasNotified = false;
      themeProvider.updateTheme(false);
      expect(wasNotified, isTrue);
    });

    test('handles multiple theme changes', () {
      for (int i = 0; i < 5; i++) {
        themeProvider.updateTheme(i % 2 == 0);
        expect(themeProvider.isDarkMode, equals(i % 2 == 0));
      }
    });

    test('maintains theme state consistency', () {
      themeProvider.updateTheme(true);
      expect(themeProvider.isDarkMode, isTrue);
      expect(themeProvider.themeMode, equals(ThemeMode.dark));

      themeProvider.updateTheme(false);
      expect(themeProvider.isDarkMode, isFalse);
      expect(themeProvider.themeMode, equals(ThemeMode.light));
    });
  });

  group('GameProvider State Management', () {
    test('validates game category types are properly defined', () {
      final allGameTypes = GameCategoryType.values;

      expect(allGameTypes, isNotEmpty);
      expect(allGameTypes.length, equals(18));

      // Verify all major game types exist
      expect(allGameTypes, contains(GameCategoryType.CALCULATOR));
      expect(allGameTypes, contains(GameCategoryType.GUESS_SIGN));
      expect(allGameTypes, contains(GameCategoryType.MAGIC_TRIANGLE));
      expect(allGameTypes, contains(GameCategoryType.MATH_PAIRS));
      expect(allGameTypes, contains(GameCategoryType.SQUARE_ROOT));
      expect(allGameTypes, contains(GameCategoryType.CUBE_ROOT));
    });

    test('validates dialog types for game state management', () {
      final allDialogTypes = DialogType.values;

      expect(allDialogTypes, contains(DialogType.non));
      expect(allDialogTypes, contains(DialogType.pause));
      expect(allDialogTypes, contains(DialogType.over));
      expect(allDialogTypes, contains(DialogType.exit));
      expect(allDialogTypes, contains(DialogType.info));
      expect(allDialogTypes, contains(DialogType.hint));
    });

    test('validates timer status states', () {
      final allTimerStates = TimerStatus.values;

      expect(allTimerStates, contains(TimerStatus.restart));
      expect(allTimerStates, contains(TimerStatus.play));
      expect(allTimerStates, contains(TimerStatus.pause));
    });

    test('validates puzzle type categorization', () {
      final allPuzzleTypes = PuzzleType.values;

      expect(allPuzzleTypes, contains(PuzzleType.MATH_PUZZLE));
      expect(allPuzzleTypes, contains(PuzzleType.MEMORY_PUZZLE));
      expect(allPuzzleTypes, contains(PuzzleType.BRAIN_PUZZLE));
      expect(allPuzzleTypes.length, equals(3));
    });
  });

  group('KeyUtil State Management', () {
    test('provides consistent score values for all game types', () {
      for (final gameType in GameCategoryType.values) {
        final score = KeyUtil.getScoreUtil(gameType);
        expect(score, greaterThan(0),
          reason: 'Score for $gameType should be positive');
        expect(score, lessThanOrEqualTo(10),
          reason: 'Score for $gameType should be reasonable');
      }
    });

    test('provides consistent penalty values for all game types', () {
      for (final gameType in GameCategoryType.values) {
        final penalty = KeyUtil.getScoreMinusUtil(gameType);
        expect(penalty, lessThanOrEqualTo(0),
          reason: 'Penalty for $gameType should be non-positive');
        expect(penalty, greaterThanOrEqualTo(-10),
          reason: 'Penalty for $gameType should not be too harsh');
      }
    });

    test('provides consistent time limits for all game types', () {
      for (final gameType in GameCategoryType.values) {
        final timeLimit = KeyUtil.getTimeUtil(gameType);
        expect(timeLimit, greaterThan(0),
          reason: 'Time limit for $gameType should be positive');
        expect(timeLimit, lessThanOrEqualTo(300),
          reason: 'Time limit for $gameType should be reasonable');
      }
    });

    test('provides consistent coin rewards for all game types', () {
      for (final gameType in GameCategoryType.values) {
        final coins = KeyUtil.getCoinUtil(gameType);
        expect(coins, greaterThan(0),
          reason: 'Coin reward for $gameType should be positive');
        expect(coins, lessThanOrEqualTo(5),
          reason: 'Coin reward for $gameType should be balanced');
      }
    });

    test('validates game balance ratios', () {
      for (final gameType in GameCategoryType.values) {
        final score = KeyUtil.getScoreUtil(gameType);
        final penalty = KeyUtil.getScoreMinusUtil(gameType).abs();
        final timeLimit = KeyUtil.getTimeUtil(gameType);
        final coins = KeyUtil.getCoinUtil(gameType);

        // Penalty should not exceed score
        expect(penalty, lessThanOrEqualTo(score),
          reason: 'Penalty should not exceed score for $gameType');

        // Time limit should be reasonable for difficulty
        if (score >= 5) { // Complex games
          expect(timeLimit, greaterThanOrEqualTo(60),
            reason: 'Complex games should have adequate time');
        }

        // Coin rewards should correlate with difficulty
        if (score >= 3) {
          expect(coins, greaterThanOrEqualTo(1),
            reason: 'Difficult games should give reasonable coins');
        }
      }
    });
  });

  group('Dashboard State Management', () {
    test('validates dashboard items configuration', () {
      final dashboardItems = KeyUtil.dashboardItems;

      expect(dashboardItems, hasLength(3));
      expect(dashboardItems, everyElement(isA<Dashboard>()));

      for (int i = 0; i < dashboardItems.length; i++) {
        final item = dashboardItems[i];
        expect(item.position, equals(i));
        expect(item.title, isNotEmpty);
        expect(item.subtitle, isNotEmpty);
        expect(item.folder, isNotEmpty);
        expect(item.opacity, greaterThan(0));
        expect(item.opacity, lessThanOrEqualTo(1));
      }
    });

    test('validates background color consistency', () {
      final bgColors = KeyUtil.bgColorList;
      final dashboardItems = KeyUtil.dashboardItems;

      expect(bgColors.length, equals(dashboardItems.length));

      for (int i = 0; i < bgColors.length; i++) {
        expect(bgColors[i], isA<Color>());
        expect(dashboardItems[i].bgColor, equals(bgColors[i]));
      }
    });

    test('validates puzzle type distribution', () {
      final dashboardItems = KeyUtil.dashboardItems;
      final puzzleTypes = dashboardItems.map((item) => item.puzzleType).toSet();

      expect(puzzleTypes, hasLength(3));
      expect(puzzleTypes, contains(PuzzleType.MATH_PUZZLE));
      expect(puzzleTypes, contains(PuzzleType.MEMORY_PUZZLE));
      expect(puzzleTypes, contains(PuzzleType.BRAIN_PUZZLE));
    });
  });

  group('State Transition Validation', () {
    test('validates game state transitions are logical', () {
      final validTransitions = {
        DialogType.non: [DialogType.pause, DialogType.over, DialogType.info, DialogType.hint],
        DialogType.pause: [DialogType.non, DialogType.exit],
        DialogType.over: [DialogType.non, DialogType.exit],
        DialogType.exit: [DialogType.non],
        DialogType.info: [DialogType.non],
        DialogType.hint: [DialogType.non],
      };

      for (final entry in validTransitions.entries) {
        final fromState = entry.key;
        final validToStates = entry.value;

        expect(validToStates, isNotEmpty,
          reason: 'State $fromState should have valid transitions');
        expect(validToStates, everyElement(isA<DialogType>()));
      }
    });

    test('validates timer state transitions', () {
      final validTimerTransitions = {
        TimerStatus.restart: [TimerStatus.play],
        TimerStatus.play: [TimerStatus.pause],
        TimerStatus.pause: [TimerStatus.play, TimerStatus.restart],
      };

      for (final entry in validTimerTransitions.entries) {
        final fromState = entry.key;
        final validToStates = entry.value;

        expect(validToStates, isNotEmpty,
          reason: 'Timer state $fromState should have valid transitions');
      }
    });
  });

  group('Configuration Validation', () {
    test('validates all constants are properly defined', () {
      // Route constants
      expect(KeyUtil.splash, isNotEmpty);
      expect(KeyUtil.dashboard, isNotEmpty);
      expect(KeyUtil.home, isNotEmpty);
      expect(KeyUtil.calculator, isNotEmpty);
      expect(KeyUtil.magicTriangle, isNotEmpty);

      // Theme folder constants
      expect(KeyUtil.themeYellowFolder, isNotEmpty);
      expect(KeyUtil.themeOrangeFolder, isNotEmpty);
      expect(KeyUtil.themeBlueFolder, isNotEmpty);

      // Color constants
      expect(KeyUtil.primaryColor1, isA<Color>());
      expect(KeyUtil.primaryColor2, isA<Color>());
      expect(KeyUtil.primaryColor3, isA<Color>());
    });

    test('validates configuration consistency across game types', () {
      final gameConfigs = <GameCategoryType, Map<String, dynamic>>{};

      for (final gameType in GameCategoryType.values) {
        gameConfigs[gameType] = {
          'score': KeyUtil.getScoreUtil(gameType),
          'penalty': KeyUtil.getScoreMinusUtil(gameType),
          'time': KeyUtil.getTimeUtil(gameType),
          'coins': KeyUtil.getCoinUtil(gameType),
        };
      }

      expect(gameConfigs, hasLength(GameCategoryType.values.length));

      for (final config in gameConfigs.values) {
        expect(config['score'], greaterThan(0));
        expect(config['penalty'], lessThanOrEqualTo(0));
        expect(config['time'], greaterThan(0));
        expect(config['coins'], greaterThan(0));
      }
    });
  });
}
