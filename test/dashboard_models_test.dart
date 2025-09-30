import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/data/models/game_category.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('Dashboard', () {
    test('creates dashboard with all required properties', () {
      final dashboard = Dashboard(
        title: 'Test Game',
        subtitle: 'Test subtitle',
        folder: 'test_folder',
        outlineIcon: 'test_icon',
        puzzleType: PuzzleType.MATH_PUZZLE,
        opacity: 0.5,
        colorTuple: Tuple2(Colors.blue, Colors.red),
        fillIconColor: Colors.green,
        outlineIconColor: Colors.yellow,
        bgColor: Colors.white,
        gridColor: Colors.grey,
        backgroundColor: Colors.black,
        primaryColor: Colors.purple,
        position: 0,
      );

      expect(dashboard.title, equals('Test Game'));
      expect(dashboard.subtitle, equals('Test subtitle'));
      expect(dashboard.folder, equals('test_folder'));
      expect(dashboard.outlineIcon, equals('test_icon'));
      expect(dashboard.puzzleType, equals(PuzzleType.MATH_PUZZLE));
      expect(dashboard.opacity, equals(0.5));
      expect(dashboard.position, equals(0));
    });

    test('handles different puzzle types', () {
      final puzzleTypes = [
        PuzzleType.MATH_PUZZLE,
        PuzzleType.MEMORY_PUZZLE,
        PuzzleType.BRAIN_PUZZLE,
      ];

      for (final puzzleType in puzzleTypes) {
        final dashboard = Dashboard(
          title: 'Test',
          subtitle: 'Test',
          folder: 'test',
          outlineIcon: 'icon',
          puzzleType: puzzleType,
          opacity: 0.1,
          colorTuple: Tuple2(Colors.red, Colors.blue),
          fillIconColor: Colors.green,
          outlineIconColor: Colors.yellow,
          bgColor: Colors.white,
          gridColor: Colors.grey,
          backgroundColor: Colors.black,
          primaryColor: Colors.purple,
          position: 0,
        );

        expect(dashboard.puzzleType, equals(puzzleType));
      }
    });

    test('handles color modifications', () {
      final dashboard = Dashboard(
        title: 'Color Test',
        subtitle: 'Testing colors',
        folder: 'colors',
        outlineIcon: 'color_icon',
        puzzleType: PuzzleType.MATH_PUZZLE,
        opacity: 0.7,
        colorTuple: Tuple2(Colors.red, Colors.blue),
        fillIconColor: Colors.green,
        outlineIconColor: Colors.yellow,
        bgColor: Colors.white,
        gridColor: Colors.grey,
        backgroundColor: Colors.black,
        primaryColor: Colors.purple,
        position: 1,
      );

      // Test that colors can be modified
      dashboard.fillIconColor = Colors.orange;
      dashboard.outlineIconColor = Colors.pink;
      dashboard.bgColor = Colors.cyan;

      expect(dashboard.fillIconColor, equals(Colors.orange));
      expect(dashboard.outlineIconColor, equals(Colors.pink));
      expect(dashboard.bgColor, equals(Colors.cyan));
    });

    test('handles various opacity values', () {
      final opacityValues = [0.0, 0.25, 0.5, 0.75, 1.0];

      for (final opacity in opacityValues) {
        final dashboard = Dashboard(
          title: 'Opacity Test',
          subtitle: 'Testing opacity',
          folder: 'opacity',
          outlineIcon: 'opacity_icon',
          puzzleType: PuzzleType.MATH_PUZZLE,
          opacity: opacity,
          colorTuple: Tuple2(Colors.red, Colors.blue),
          fillIconColor: Colors.green,
          outlineIconColor: Colors.yellow,
          bgColor: Colors.white,
          gridColor: Colors.grey,
          backgroundColor: Colors.black,
          primaryColor: Colors.purple,
          position: 0,
        );

        expect(dashboard.opacity, equals(opacity));
        expect(dashboard.opacity, greaterThanOrEqualTo(0.0));
        expect(dashboard.opacity, lessThanOrEqualTo(1.0));
      }
    });

    test('handles position values', () {
      final positions = [0, 1, 2, 5, 10];

      for (final position in positions) {
        final dashboard = Dashboard(
          title: 'Position Test',
          subtitle: 'Testing position',
          folder: 'position',
          outlineIcon: 'position_icon',
          puzzleType: PuzzleType.BRAIN_PUZZLE,
          opacity: 0.5,
          colorTuple: Tuple2(Colors.red, Colors.blue),
          fillIconColor: Colors.green,
          outlineIconColor: Colors.yellow,
          bgColor: Colors.white,
          gridColor: Colors.grey,
          backgroundColor: Colors.black,
          primaryColor: Colors.purple,
          position: position,
        );

        expect(dashboard.position, equals(position));
        expect(dashboard.position, greaterThanOrEqualTo(0));
      }
    });

    test('handles special folder names', () {
      final specialNames = [
        'imgYellow/',
        'imgGreen/',
        'imgBlue/',
        'test-folder',
        'folder_with_underscores',
        '',
      ];

      for (final name in specialNames) {
        final dashboard = Dashboard(
          title: 'Folder Test',
          subtitle: 'Testing folders',
          folder: name,
          outlineIcon: 'folder_icon',
          puzzleType: PuzzleType.MEMORY_PUZZLE,
          opacity: 0.3,
          colorTuple: Tuple2(Colors.red, Colors.blue),
          fillIconColor: Colors.green,
          outlineIconColor: Colors.yellow,
          bgColor: Colors.white,
          gridColor: Colors.grey,
          backgroundColor: Colors.black,
          primaryColor: Colors.purple,
          position: 0,
        );

        expect(dashboard.folder, equals(name));
      }
    });

    test('handles color tuple properly', () {
      final colorTuple = Tuple2(Colors.red, Colors.blue);
      final dashboard = Dashboard(
        title: 'Tuple Test',
        subtitle: 'Testing color tuple',
        folder: 'tuple',
        outlineIcon: 'tuple_icon',
        puzzleType: PuzzleType.MATH_PUZZLE,
        opacity: 0.8,
        colorTuple: colorTuple,
        fillIconColor: Colors.green,
        outlineIconColor: Colors.yellow,
        bgColor: Colors.white,
        gridColor: Colors.grey,
        backgroundColor: Colors.black,
        primaryColor: Colors.purple,
        position: 2,
      );

      expect(dashboard.colorTuple, equals(colorTuple));
      expect(dashboard.colorTuple.item1, equals(Colors.red));
      expect(dashboard.colorTuple.item2, equals(Colors.blue));
    });
  });

  group('GameCategory', () {
    test('creates game category with all required properties', () {
      final gameCategory = GameCategory(
        name: 'Calculator',
        key: 'calculator',
        routePath: '/calculator',
        colorTuple: null,
      );

      expect(gameCategory.name, equals('Calculator'));
      expect(gameCategory.key, equals('calculator'));
      expect(gameCategory.routePath, equals('/calculator'));
      expect(gameCategory.colorTuple, isNull);
    });

    test('handles empty name and key', () {
      final gameCategory = GameCategory(
        name: '',
        key: '',
        routePath: '/',
        colorTuple: null,
      );

      expect(gameCategory.name, isEmpty);
      expect(gameCategory.key, isEmpty);
      expect(gameCategory.routePath, equals('/'));
    });

    test('handles various route paths', () {
      final routePaths = [
        '/calculator',
        '/guess-sign',
        '/square-root',
        '/mental-arithmetic',
        '/magic-triangle',
      ];

      for (final route in routePaths) {
        final gameCategory = GameCategory(
          name: 'Test Game',
          key: 'test_game',
          routePath: route,
          colorTuple: null,
        );

        expect(gameCategory.routePath, equals(route));
      }
    });

    test('handles special characters in names', () {
      final gameCategory = GameCategory(
        name: 'Math & Logic',
        key: 'math_logic',
        routePath: '/math-logic',
        colorTuple: null,
      );

      expect(gameCategory.name, contains('&'));
      expect(gameCategory.key, contains('_'));
      expect(gameCategory.routePath, contains('-'));
    });

    test('supports long names and keys', () {
      final longName = 'Very Long Game Category Name That Tests String Handling';
      final longKey = 'very_long_game_category_key_that_tests_string_handling';

      final gameCategory = GameCategory(
        name: longName,
        key: longKey,
        routePath: '/long-route',
        colorTuple: null,
      );

      expect(gameCategory.name, equals(longName));
      expect(gameCategory.key, equals(longKey));
      expect(gameCategory.name.length, greaterThan(20));
      expect(gameCategory.key.length, greaterThan(20));
    });

    test('handles unicode characters in names', () {
      final gameCategory = GameCategory(
        name: 'Math Games 数学 🎮',
        key: 'math_games_unicode',
        routePath: '/math-games',
        colorTuple: null,
      );

      expect(gameCategory.name, contains('数学'));
      expect(gameCategory.name, contains('🎮'));
    });

    test('maintains property immutability', () {
      final gameCategory = GameCategory(
        name: 'Test Game',
        key: 'test_key',
        routePath: '/test',
        colorTuple: null,
      );

      final originalName = gameCategory.name;
      final originalKey = gameCategory.key;
      final originalRoutePath = gameCategory.routePath;
      final originalColorTuple = gameCategory.colorTuple;

      expect(gameCategory.name, equals(originalName));
      expect(gameCategory.key, equals(originalKey));
      expect(gameCategory.routePath, equals(originalRoutePath));
      expect(gameCategory.colorTuple, equals(originalColorTuple));
    });
  });
}
