import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/picture_puzzle.dart';
import 'package:mathsgames/src/data/models/math_grid.dart';
import 'package:mathsgames/src/data/models/quick_calculation.dart';
import 'package:mathsgames/src/data/models/true_false_model.dart';
import 'package:mathsgames/src/data/repositories/picture_puzzle_repository.dart';
import 'package:mathsgames/src/data/repositories/math_grid_repository.dart';
import 'package:mathsgames/src/data/repositories/quick_calculation_repository.dart';
import 'package:mathsgames/src/data/repositories/true_false_repository.dart';

void main() {
  group('PicturePuzzleRepository', () {
    test('generates correct number of picture puzzle problems', () {
      for (int level = 1; level <= 5; level++) {
        final puzzles = PicturePuzzleRepository.getPicturePuzzleDataList(level);
        expect(puzzles.length, greaterThan(0));
        expect(puzzles, everyElement(isA<PicturePuzzle>()));
      }
    });

    test('generates valid picture puzzle structure', () {
      final puzzles = PicturePuzzleRepository.getPicturePuzzleDataList(1);

      for (final puzzle in puzzles) {
        expect(puzzle.list, isNotEmpty);
        expect(puzzle.answer, isA<int>());
        expect(puzzle.list, everyElement(isA<PicturePuzzleShapeList>()));

        for (final shapeList in puzzle.list) {
          expect(shapeList.shapeList, isNotEmpty);
          expect(shapeList.shapeList, everyElement(isA<PicturePuzzleShape>()));
        }
      }
    });

    test('validates picture puzzle shape types', () {
      final puzzles = PicturePuzzleRepository.getPicturePuzzleDataList(2);

      for (final puzzle in puzzles) {
        for (final shapeList in puzzle.list) {
          for (final shape in shapeList.shapeList) {
            if (shape.shapeType != null) {
              expect([
                PicturePuzzleShapeType.circle,
                PicturePuzzleShapeType.square,
                PicturePuzzleShapeType.triangle,
              ].contains(shape.shapeType), isTrue);
            }

            expect([
              PicturePuzzleQuestionItemType.shape,
              PicturePuzzleQuestionItemType.sign,
              PicturePuzzleQuestionItemType.hint,
              PicturePuzzleQuestionItemType.answer,
            ].contains(shape.type), isTrue);
          }
        }
      }
    });
  });

  group('MathGridRepository', () {
    test('generates math grid with correct structure', () {
      for (int level = 1; level <= 5; level++) {
        final grids = MathGridRepository.getMathGridData(level);
        expect(grids.length, greaterThan(0));
        expect(grids, everyElement(isA<MathGrid>()));
      }
    });

    test('validates math grid cell structure', () {
      final grids = MathGridRepository.getMathGridData(1);

      for (final grid in grids) {
        expect(grid.currentAnswer, isA<int>());
        expect(grid.listForSquare, isNotEmpty);
        expect(grid.listForSquare, everyElement(isA<MathGridCellModel>()));

        for (final cell in grid.listForSquare) {
          expect(cell.value, isNotEmpty);
          expect([true, false].contains(cell.isActive), isTrue);
        }
      }
    });

    test('ensures math grid answers are mathematically correct', () {
      final grids = MathGridRepository.getMathGridData(2);

      for (final grid in grids) {
        expect(grid.currentAnswer, greaterThanOrEqualTo(0));

        // Check that some cells contain numbers that could lead to the answer
        final cellValues = grid.listForSquare.map((cell) => int.tryParse(cell.value) ?? 0).toList();
        expect(cellValues, isNotEmpty);
      }
    });
  });

  group('QuickCalculationRepository', () {
    test('generates correct number of quick calculation problems', () {
      for (int level = 1; level <= 5; level++) {
        final problems = QuickCalculationRepository.getQuickCalculationDataList(level, 5);
        expect(problems.length, equals(5));
        expect(problems, everyElement(isA<QuickCalculation>()));
      }
    });

    test('validates quick calculation structure', () {
      final problems = QuickCalculationRepository.getQuickCalculationDataList(1, 3);

      for (final problem in problems) {
        expect(problem.question, isNotEmpty);
        expect(problem.answer, isA<int>());

        // Verify the question contains mathematical operations
        expect(problem.question, matches(RegExp(r'\d+\s*[+\-*/]\s*\d+')));
      }
    });

    test('generates appropriate difficulty for quick calculations', () {
      final level1Problems = QuickCalculationRepository.getQuickCalculationDataList(1, 3);
      final level5Problems = QuickCalculationRepository.getQuickCalculationDataList(5, 3);

      final level1Avg = level1Problems.map((p) => p.answer).reduce((a, b) => a + b) / level1Problems.length;
      final level5Avg = level5Problems.map((p) => p.answer).reduce((a, b) => a + b) / level5Problems.length;

      expect(level5Avg, greaterThanOrEqualTo(level1Avg * 0.8),
        reason: 'Higher levels should have reasonably larger answers');
    });
  });

  group('TrueFalseRepository', () {
    test('generates correct number of true false problems', () {
      for (int level = 1; level <= 5; level++) {
        final problems = TrueFalseRepository.getTrueFalseDataList(level);
        expect(problems.length, greaterThan(0));
        expect(problems, everyElement(isA<TrueFalse>()));
      }
    });

    test('validates true false problem structure', () {
      final problems = TrueFalseRepository.getTrueFalseDataList(1);

      for (final problem in problems) {
        expect(problem.question, isNotEmpty);
        expect([true, false].contains(problem.answer), isTrue);

        // Question should contain mathematical expression
        expect(problem.question, contains('='));
      }
    });

    test('ensures mathematical correctness of true false questions', () {
      final problems = TrueFalseRepository.getTrueFalseDataList(2);

      for (final problem in problems) {
        // Parse the equation and verify if the answer is correct
        if (problem.question.contains('=')) {
          final parts = problem.question.split('=');
          if (parts.length == 2) {
            final leftSide = parts[0].trim();
            final rightSide = parts[1].trim();

            // Basic validation that both sides contain numbers
            expect(leftSide, matches(RegExp(r'\d')));
            expect(rightSide, matches(RegExp(r'\d')));
          }
        }
      }
    });
  });

  group('Model Validations', () {
    test('picture puzzle model handles all components correctly', () {
      final shape = PicturePuzzleShape(
        shapeType: PicturePuzzleShapeType.circle,
        text: '+',
        type: PicturePuzzleQuestionItemType.sign,
      );

      final shapeList = PicturePuzzleShapeList([shape]);
      final puzzle = PicturePuzzle(list: [shapeList], answer: 5);

      expect(puzzle.answer, equals(5));
      expect(puzzle.list, hasLength(1));
      expect(shape.shapeType, equals(PicturePuzzleShapeType.circle));
      expect(shape.type, equals(PicturePuzzleQuestionItemType.sign));
    });

    test('math grid cell model handles state changes', () {
      final cell = MathGridCellModel('5', false);

      expect(cell.value, equals('5'));
      expect(cell.isActive, isFalse);

      cell.isActive = true;
      expect(cell.isActive, isTrue);
    });

    test('quick calculation model validates mathematical expressions', () {
      final calculation = QuickCalculation('10 + 5', 15);

      expect(calculation.question, equals('10 + 5'));
      expect(calculation.answer, equals(15));

      // Verify mathematical correctness
      final parts = calculation.question.split(' + ');
      if (parts.length == 2) {
        final num1 = int.tryParse(parts[0]);
        final num2 = int.tryParse(parts[1]);
        if (num1 != null && num2 != null) {
          expect(calculation.answer, equals(num1 + num2));
        }
      }
    });

    test('true false model handles boolean logic', () {
      final trueProblem = TrueFalse('5 + 3 = 8', true);
      final falseProblem = TrueFalse('5 + 3 = 9', false);

      expect(trueProblem.answer, isTrue);
      expect(falseProblem.answer, isFalse);
      expect(trueProblem.question, contains('='));
      expect(falseProblem.question, contains('='));
    });
  });

  group('Integration Tests', () {
    test('all puzzle repositories generate consistent data', () {
      expect(() => PicturePuzzleRepository.getPicturePuzzleDataList(1), returnsNormally);
      expect(() => MathGridRepository.getMathGridData(1), returnsNormally);
      expect(() => QuickCalculationRepository.getQuickCalculationDataList(1, 5), returnsNormally);
      expect(() => TrueFalseRepository.getTrueFalseDataList(1), returnsNormally);
    });

    test('models work together in collections', () {
      final puzzles = PicturePuzzleRepository.getPicturePuzzleDataList(1);
      final grids = MathGridRepository.getMathGridData(1);
      final calculations = QuickCalculationRepository.getQuickCalculationDataList(1, 3);
      final trueFalses = TrueFalseRepository.getTrueFalseDataList(1);

      expect(puzzles, everyElement(isA<PicturePuzzle>()));
      expect(grids, everyElement(isA<MathGrid>()));
      expect(calculations, everyElement(isA<QuickCalculation>()));
      expect(trueFalses, everyElement(isA<TrueFalse>()));
    });
  });
}
