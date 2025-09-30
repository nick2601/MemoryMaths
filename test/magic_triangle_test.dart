import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/magic_triangle.dart';
import 'package:mathsgames/src/data/repositories/magic_triangle_repository.dart';

void main() {
  group('MagicTriangleRepository', () {
    test('generates correct number of basic level triangles', () {
      final triangles = MagicTriangleRepository.getTriangleDataProviderList();

      expect(triangles.length, equals(5));
      expect(triangles, everyElement(isA<MagicTriangle>()));
    });

    test('generates correct number of advanced level triangles', () {
      final triangles = MagicTriangleRepository.getNextLevelTriangleDataProviderList();

      expect(triangles.length, equals(4));
      expect(triangles, everyElement(isA<MagicTriangle>()));
    });

    test('basic level triangles use 6 numbers', () {
      final triangles = MagicTriangleRepository.getTriangleDataProviderList();

      for (final triangle in triangles) {
        expect(triangle.listGrid.length, equals(6));
        expect(triangle.listTriangle.length, equals(6));
        expect(triangle.is3x3, isTrue);
      }
    });

    test('advanced level triangles use 9 numbers', () {
      final triangles = MagicTriangleRepository.getNextLevelTriangleDataProviderList();

      for (final triangle in triangles) {
        expect(triangle.listGrid.length, equals(9));
        expect(triangle.listTriangle.length, equals(9));
        expect(triangle.is3x3, isFalse);
      }
    });

    test('generates grid with correct number range for basic level', () {
      final grid = MagicTriangleRepository.getMagicTriangleGrid([1, 2, 3, 4, 5, 6]);

      expect(grid.length, equals(6));
      expect(grid, everyElement(isA<MagicTriangleGrid>()));

      final values = grid.map((g) => int.parse(g.value)).toList();
      expect(values, containsAll([1, 2, 3, 4, 5, 6]));
    });

    test('generates grid with all items visible by default', () {
      final grid = MagicTriangleRepository.getMagicTriangleGrid([1, 2, 3]);

      for (final item in grid) {
        expect(item.isVisible, isTrue);
      }
    });

    test('generates input fields with correct length', () {
      final inputs = MagicTriangleRepository.getMagicTriangleInput(6);

      expect(inputs.length, equals(6));
      expect(inputs, everyElement(isA<MagicTriangleInput>()));
    });

    test('generates input fields as inactive by default', () {
      final inputs = MagicTriangleRepository.getMagicTriangleInput(9);

      for (final input in inputs) {
        expect(input.isActive, isFalse);
        expect(input.value, isEmpty);
      }
    });

    test('basic level triangles have valid target answers', () {
      final triangles = MagicTriangleRepository.getTriangleDataProviderList();
      final validAnswers = [9, 10, 11, 12, 18];

      for (final triangle in triangles) {
        expect(validAnswers.contains(triangle.answer), isTrue);
      }
    });

    test('advanced level triangles have valid target answers', () {
      final triangles = MagicTriangleRepository.getNextLevelTriangleDataProviderList();
      final validAnswers = [20, 21, 23, 126];

      for (final triangle in triangles) {
        expect(validAnswers.contains(triangle.answer), isTrue);
      }
    });

    test('grid items are shuffled', () {
      final originalOrder = [1, 2, 3, 4, 5, 6];
      final grid1 = MagicTriangleRepository.getMagicTriangleGrid(List.from(originalOrder));
      final grid2 = MagicTriangleRepository.getMagicTriangleGrid(List.from(originalOrder));

      final values1 = grid1.map((g) => int.parse(g.value)).toList();
      final values2 = grid2.map((g) => int.parse(g.value)).toList();

      // At least one should be different from original order (with high probability)
      final isShuffled = !values1.equals(originalOrder) || !values2.equals(originalOrder);
      expect(isShuffled, isTrue);
    });

    test('generates different triangle configurations each time', () {
      final triangles1 = MagicTriangleRepository.getTriangleDataProviderList();
      final triangles2 = MagicTriangleRepository.getTriangleDataProviderList();

      // Check that the grid arrangements are different (shuffled)
      final grids1 = triangles1.map((t) => t.listGrid.map((g) => int.parse(g.value)).toList()).toList();
      final grids2 = triangles2.map((t) => t.listGrid.map((g) => int.parse(g.value)).toList()).toList();

      expect(grids1, isNot(equals(grids2)));
    });

    test('maintains number integrity during grid generation', () {
      final numbers = [4, 5, 6, 7, 8, 9];
      final grid = MagicTriangleRepository.getMagicTriangleGrid(numbers);
      final gridValues = grid.map((g) => int.parse(g.value)).toList()..sort();
      final sortedNumbers = List.from(numbers)..sort();

      expect(gridValues, equals(sortedNumbers));
    });
  });

  group('MagicTriangle', () {
    test('correctly identifies 3x3 triangle', () {
      final triangle = MagicTriangle(
        listGrid: List.generate(6, (i) => MagicTriangleGrid((i + 1).toString(), true)),
        listTriangle: List.generate(6, (i) => MagicTriangleInput(false, '')),
        answer: 9,
      );

      expect(triangle.is3x3, isTrue);
    });

    test('correctly identifies 4x4 triangle', () {
      final triangle = MagicTriangle(
        listGrid: List.generate(9, (i) => MagicTriangleGrid((i + 1).toString(), true)),
        listTriangle: List.generate(9, (i) => MagicTriangleInput(false, '')),
        answer: 17,
      );

      expect(triangle.is3x3, isFalse);
    });

    test('calculates available digits correctly', () {
      final grid = [
        MagicTriangleGrid('1', true),
        MagicTriangleGrid('2', false),
        MagicTriangleGrid('3', true),
        MagicTriangleGrid('4', true),
      ];

      final triangle = MagicTriangle(
        listGrid: grid,
        listTriangle: [],
        answer: 9,
      );

      expect(triangle.availableDigit, equals(4));
    });

    test('validates 3x3 triangle solution correctly', () {
      final triangle = MagicTriangle(
        listGrid: [],
        listTriangle: [
          MagicTriangleInput(false, '6'), // top
          MagicTriangleInput(false, '1'), // left middle
          MagicTriangleInput(false, '2'), // right middle
          MagicTriangleInput(false, '3'), // bottom left
          MagicTriangleInput(false, '4'), // bottom middle
          MagicTriangleInput(false, '5'), // bottom right
        ],
        answer: 9,
      );

      expect(triangle.checkTotal(), isTrue);
    });

    test('validates 4x4 triangle solution correctly', () {
      final triangle = MagicTriangle(
        listGrid: [],
        listTriangle: [
          MagicTriangleInput(false, '9'), // top
          MagicTriangleInput(false, '1'), // second row left
          MagicTriangleInput(false, '2'), // second row right
          MagicTriangleInput(false, '3'), // third row left
          MagicTriangleInput(false, '4'), // third row right
          MagicTriangleInput(false, '5'), // bottom left
          MagicTriangleInput(false, '6'), // bottom middle left
          MagicTriangleInput(false, '7'), // bottom middle right
          MagicTriangleInput(false, '8'), // bottom right
        ],
        answer: 20,
      );

      expect(triangle.checkTotal(), isTrue);
    });

    test('rejects invalid 3x3 triangle solution', () {
      final triangle = MagicTriangle(
        listGrid: [],
        listTriangle: [
          MagicTriangleInput(false, '1'),
          MagicTriangleInput(false, '2'),
          MagicTriangleInput(false, '3'),
          MagicTriangleInput(false, '4'),
          MagicTriangleInput(false, '5'),
          MagicTriangleInput(false, '6'),
        ],
        answer: 15, // Wrong target
      );

      expect(triangle.checkTotal(), isFalse);
    });

    test('handles incomplete triangle solution', () {
      final triangle = MagicTriangle(
        listGrid: [],
        listTriangle: [
          MagicTriangleInput(false, '1'),
          MagicTriangleInput(false, ''), // Missing value
          MagicTriangleInput(false, '3'),
          MagicTriangleInput(false, '4'),
          MagicTriangleInput(false, '5'),
          MagicTriangleInput(false, '6'),
        ],
        answer: 9,
      );

      expect(() => triangle.checkTotal(), throwsA(isA<FormatException>()));
    });
  });

  group('MagicTriangleGrid', () {
    test('creates grid item with correct properties', () {
      final gridItem = MagicTriangleGrid('5', true);

      expect(gridItem.value, equals('5'));
      expect(gridItem.isVisible, isTrue);
    });

    test('allows visibility to be changed', () {
      final gridItem = MagicTriangleGrid('3', true);

      gridItem.isVisible = false;
      expect(gridItem.isVisible, isFalse);
    });
  });

  group('MagicTriangleInput', () {
    test('creates input with correct initial state', () {
      final input = MagicTriangleInput(false, '');

      expect(input.isActive, isFalse);
      expect(input.value, isEmpty);
    });

    test('allows state to be modified', () {
      final input = MagicTriangleInput(false, '');

      input.isActive = true;
      input.value = '5';

      expect(input.isActive, isTrue);
      expect(input.value, equals('5'));
    });

    test('handles various value types', () {
      final input = MagicTriangleInput(true, '42');

      expect(input.value, equals('42'));
      expect(input.value, isA<String>());
    });
  });
}

extension ListEquals<T> on List<T> {
  bool equals(List<T> other) {
    if (length != other.length) return false;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
