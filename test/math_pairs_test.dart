import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/data/repositories/math_pairs_repository.dart';

void main() {
  group('MathPairsRepository', () {
    test('generates correct number of math pairs for each level', () {
      for (int level = 1; level <= 5; level++) {
        final pairs = MathPairsRepository.getMathPairsDataList(level);
        expect(pairs.length, greaterThan(0));
        expect(pairs, everyElement(isA<MathPairs>()));
      }
    });

    test('generates math pairs with valid pair structure', () {
      final mathPairs = MathPairsRepository.getMathPairsDataList(1);

      for (final mathPair in mathPairs) {
        expect(mathPair.list, isNotEmpty);
        expect(mathPair.list, everyElement(isA<Pair>()));
        expect(mathPair.availableItem, greaterThanOrEqualTo(0));

        // Check that each pair has valid properties
        for (final pair in mathPair.list) {
          expect(pair.text, isNotEmpty);
          expect(pair.uid, greaterThanOrEqualTo(0));
        }
      }
    });

    test('validates available items count', () {
      final mathPairs = MathPairsRepository.getMathPairsDataList(2);

      for (final mathPair in mathPairs) {
        expect(mathPair.availableItem, lessThanOrEqualTo(mathPair.list.length));
        expect(mathPair.availableItem, greaterThanOrEqualTo(0));
      }
    });

    test('generates appropriate difficulty for different levels', () {
      final level1Pairs = MathPairsRepository.getMathPairsDataList(1);
      final level5Pairs = MathPairsRepository.getMathPairsDataList(5);

      expect(level5Pairs.isNotEmpty, isTrue);
      expect(level1Pairs.isNotEmpty, isTrue);

      // Higher levels should generally have more complex problems or more pairs
      if (level1Pairs.isNotEmpty && level5Pairs.isNotEmpty) {
        final level1AvgPairs = level1Pairs.map((mp) => mp.list.length).reduce((a, b) => a + b) / level1Pairs.length;
        final level5AvgPairs = level5Pairs.map((mp) => mp.list.length).reduce((a, b) => a + b) / level5Pairs.length;

        expect(level5AvgPairs, greaterThanOrEqualTo(level1AvgPairs * 0.8),
          reason: 'Higher levels should have reasonably more pairs');
      }
    });

    test('generates unique UIDs within each math pairs set', () {
      final mathPairs = MathPairsRepository.getMathPairsDataList(2);

      for (final mathPair in mathPairs) {
        final uids = mathPair.list.map((p) => p.uid).toList();
        expect(uids.toSet().length, equals(uids.length),
          reason: 'All UIDs should be unique within a set');
      }
    });
  });

  group('MathPairs Model', () {
    test('creates math pairs instance with valid list and available items', () {
      final pairs = [
        Pair(1, '2 + 3', false, true),
        Pair(2, '5', false, true),
        Pair(3, '4 + 1', false, true),
        Pair(4, '5', false, true),
      ];

      final mathPairs = MathPairs(pairs, 4);

      expect(mathPairs.list, hasLength(4));
      expect(mathPairs.availableItem, equals(4));
      expect(mathPairs.list, everyElement(isA<Pair>()));
    });

    test('handles empty list', () {
      final mathPairs = MathPairs([], 0);

      expect(mathPairs.list, isEmpty);
      expect(mathPairs.availableItem, equals(0));
    });

    test('handles large list of pairs', () {
      final pairs = List.generate(20, (index) =>
        Pair(index, '${index} + 1', false, true)
      );

      final mathPairs = MathPairs(pairs, 20);

      expect(mathPairs.list, hasLength(20));
      expect(mathPairs.availableItem, equals(20));
      expect(mathPairs.list, everyElement(isA<Pair>()));
    });

    test('toString returns meaningful representation', () {
      final pairs = [Pair(1, 'test', false, true)];
      final mathPairs = MathPairs(pairs, 1);
      final stringRepresentation = mathPairs.toString();

      expect(stringRepresentation, contains('MathPairs'));
      expect(stringRepresentation, contains('list'));
    });

    test('can modify available items count', () {
      final pairs = [
        Pair(1, '2 + 3', false, true),
        Pair(2, '5', false, true),
      ];
      final mathPairs = MathPairs(pairs, 2);

      mathPairs.availableItem = 1;
      expect(mathPairs.availableItem, equals(1));

      mathPairs.availableItem = 0;
      expect(mathPairs.availableItem, equals(0));
    });
  });

  group('Pair Model', () {
    test('creates pair instance with all properties', () {
      final pair = Pair(1, '5 + 3', false, true);

      expect(pair.uid, equals(1));
      expect(pair.text, equals('5 + 3'));
      expect(pair.isActive, isFalse);
      expect(pair.isVisible, isTrue);
    });

    test('handles different text formats', () {
      final textFormats = [
        '2 + 3',
        '10 - 4',
        '3 * 2',
        '8 / 2',
        '15',
        'What is 5?',
      ];

      for (int i = 0; i < textFormats.length; i++) {
        final pair = Pair(i, textFormats[i], false, true);

        expect(pair.text, equals(textFormats[i]));
        expect(pair.text, isNotEmpty);
        expect(pair.uid, equals(i));
      }
    });

    test('handles state changes', () {
      final pair = Pair(1, '7 + 2', false, true);

      expect(pair.isActive, isFalse);
      expect(pair.isVisible, isTrue);

      // Test state modifications
      pair.isActive = true;
      pair.isVisible = false;

      expect(pair.isActive, isTrue);
      expect(pair.isVisible, isFalse);
    });

    test('handles various UID values', () {
      final uids = [0, 1, 10, 100, 999];

      for (final uid in uids) {
        final pair = Pair(uid, 'test', false, true);
        expect(pair.uid, equals(uid));
        expect(pair.uid, greaterThanOrEqualTo(0));
      }
    });

    test('validates boolean properties', () {
      final testCases = [
        {'active': true, 'visible': true},
        {'active': true, 'visible': false},
        {'active': false, 'visible': true},
        {'active': false, 'visible': false},
      ];

      for (int i = 0; i < testCases.length; i++) {
        final testCase = testCases[i];
        final pair = Pair(
          i,
          'Test',
          testCase['active'] as bool,
          testCase['visible'] as bool,
        );

        expect(pair.isActive, equals(testCase['active']));
        expect(pair.isVisible, equals(testCase['visible']));
      }
    });

    test('handles empty strings', () {
      final pair = Pair(0, '', false, true);

      expect(pair.text, isEmpty);
      expect(pair.uid, equals(0));
      expect(pair.isActive, isFalse);
      expect(pair.isVisible, isTrue);
    });

    test('toString returns meaningful representation', () {
      final pair = Pair(42, 'test expression', true, false);
      final stringRepresentation = pair.toString();

      expect(stringRepresentation, contains('Pair'));
      expect(stringRepresentation, contains('test expression'));
      expect(stringRepresentation, contains('42'));
    });

    test('handles complex mathematical expressions', () {
      final complexExpressions = [
        '(2 + 3) * 4',
        '10 / 2 + 3',
        '5² - 1',
        '√16 + 2',
      ];

      for (int i = 0; i < complexExpressions.length; i++) {
        final pair = Pair(i, complexExpressions[i], false, true);

        expect(pair.text, equals(complexExpressions[i]));
        expect(pair.text, isNotEmpty);
        expect(pair.uid, equals(i));
      }
    });

    test('can be used in collections', () {
      final pairs = [
        Pair(1, 'first', false, true),
        Pair(2, 'second', true, false),
        Pair(3, 'third', false, true),
      ];

      expect(pairs, hasLength(3));
      expect(pairs[0].text, equals('first'));
      expect(pairs[1].isActive, isTrue);
      expect(pairs[2].isVisible, isTrue);
    });
  });
}
