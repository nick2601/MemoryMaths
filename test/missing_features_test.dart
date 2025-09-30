import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/find_missing_model.dart';
import 'package:mathsgames/src/data/models/complex_data.dart';
import 'package:mathsgames/src/data/models/quiz_model.dart';
import 'package:mathsgames/src/data/models/score_board.dart';
import 'package:mathsgames/src/data/repositories/find_missing_repository.dart';
import 'package:mathsgames/src/data/repositories/complex_calcualtion_repository.dart';

void main() {
  group('FindMissingRepository', () {
    test('generates correct number of find missing problems', () {
      for (int level = 1; level <= 5; level++) {
        final problems = FindMissingRepository.getFindMissingDataList(level);
        expect(problems.length, equals(5));
        expect(problems, everyElement(isA<FindMissing>()));
      }
    });

    test('validates find missing problem structure', () {
      final problems = FindMissingRepository.getFindMissingDataList(1);

      for (final problem in problems) {
        expect(problem.question, isNotEmpty);
        expect(problem.answer, isA<int>());
        expect(problem.firstAns, isNotEmpty);
        expect(problem.secondAns, isNotEmpty);
        expect(problem.thirdAns, isNotEmpty);
        expect(problem.fourthAns, isNotEmpty);

        // Question should have a missing part (indicated by ?)
        expect(problem.question, contains('?'));
      }
    });

    test('ensures correct answer is included in options', () {
      final problems = FindMissingRepository.getFindMissingDataList(2);

      for (final problem in problems) {
        final answerOptions = [
          problem.firstAns,
          problem.secondAns,
          problem.thirdAns,
          problem.fourthAns,
        ];

        final correctAnswerString = problem.answer.toString();
        expect(answerOptions, contains(correctAnswerString));
      }
    });
  });

  group('ComplexCalculationRepository', () {
    test('generates complex calculation problems', () {
      for (int level = 1; level <= 5; level++) {
        final problems = ComplexCalculationRepository.getComplexData(level);
        expect(problems.length, greaterThan(0));
        expect(problems, everyElement(isA<ComplexData>()));
      }
    });

    test('validates complex calculation structure', () {
      final problems = ComplexCalculationRepository.getComplexData(1);

      for (final problem in problems) {
        expect(problem.question, isNotEmpty);
        expect(problem.answer, isA<int>());
        expect(problem.optionList, isNotEmpty);
        expect(problem.optionList, everyElement(isA<String>()));

        // Complex calculations should have multiple operations
        final operatorCount = problem.question.split(RegExp(r'[+\-*/]')).length - 1;
        expect(operatorCount, greaterThanOrEqualTo(1));
      }
    });

    test('ensures correct answer is in option list', () {
      final problems = ComplexCalculationRepository.getComplexData(3);

      for (final problem in problems) {
        expect(problem.optionList, contains(problem.answer.toString()));

        // Options should be unique
        final uniqueOptions = problem.optionList.toSet();
        expect(uniqueOptions.length, equals(problem.optionList.length));
      }
    });
  });

  group('FindMissing Model', () {
    test('creates find missing instance with all properties', () {
      final findMissing = FindMissing(
        question: '5 + ? = 8',
        answer: 3,
        firstAns: '3',
        secondAns: '2',
        thirdAns: '4',
        fourthAns: '1',
      );

      expect(findMissing.question, equals('5 + ? = 8'));
      expect(findMissing.answer, equals(3));
      expect(findMissing.firstAns, equals('3'));
      expect(findMissing.secondAns, equals('2'));
      expect(findMissing.thirdAns, equals('4'));
      expect(findMissing.fourthAns, equals('1'));
    });

    test('handles various missing number positions', () {
      final testCases = [
        '? + 3 = 8',
        '5 + ? = 8',
        '5 - ? = 2',
        '? * 4 = 12',
        '15 / ? = 3',
      ];

      for (int i = 0; i < testCases.length; i++) {
        final findMissing = FindMissing(
          question: testCases[i],
          answer: 3,
          firstAns: '3',
          secondAns: '2',
          thirdAns: '4',
          fourthAns: '5',
        );

        expect(findMissing.question, contains('?'));
        expect(findMissing.question, matches(RegExp(r'[+\-*/=]')));
      }
    });
  });

  group('ComplexData Model', () {
    test('creates complex data instance with valid properties', () {
      final complexData = ComplexData(
        question: '(5 + 3) * 2 - 1',
        answer: 15,
        optionList: ['15', '14', '16', '13'],
      );

      expect(complexData.question, equals('(5 + 3) * 2 - 1'));
      expect(complexData.answer, equals(15));
      expect(complexData.optionList, hasLength(4));
      expect(complexData.optionList, contains('15'));
    });

    test('handles complex mathematical expressions', () {
      final expressions = [
        '10 + 5 * 2',
        '(8 - 3) * 4',
        '20 / 4 + 7',
        '15 - 3 * 2',
      ];

      for (final expression in expressions) {
        final complexData = ComplexData(
          question: expression,
          answer: 10,
          optionList: ['10', '9', '11', '8'],
        );

        expect(complexData.question, equals(expression));
        expect(complexData.question, matches(RegExp(r'[+\-*/()]')));
      }
    });
  });

  group('QuizModel', () {
    test('creates quiz model with valid properties', () {
      final quiz = QuizModel(
        question: 'What is 2 + 2?',
        options: ['4', '3', '5', '2'],
        correctAnswer: 0,
      );

      expect(quiz.question, equals('What is 2 + 2?'));
      expect(quiz.options, hasLength(4));
      expect(quiz.correctAnswer, equals(0));
      expect(quiz.options[quiz.correctAnswer], equals('4'));
    });

    test('handles various question types', () {
      final questions = [
        'What is the square root of 16?',
        'Solve: 5 × 3 = ?',
        'Which number is missing: 2, 4, ?, 8',
        'True or False: 10 > 5',
      ];

      for (int i = 0; i < questions.length; i++) {
        final quiz = QuizModel(
          question: questions[i],
          options: ['A', 'B', 'C', 'D'],
          correctAnswer: i % 4,
        );

        expect(quiz.question, equals(questions[i]));
        expect(quiz.correctAnswer, lessThan(quiz.options.length));
      }
    });

    test('validates correct answer index bounds', () {
      final quiz = QuizModel(
        question: 'Test question',
        options: ['A', 'B', 'C'],
        correctAnswer: 1,
      );

      expect(quiz.correctAnswer, greaterThanOrEqualTo(0));
      expect(quiz.correctAnswer, lessThan(quiz.options.length));
    });
  });

  group('ScoreBoard Model', () {
    test('creates score board with player information', () {
      final scoreBoard = ScoreBoard(
        gameCategoryType: GameCategoryType.CALCULATOR,
        level: 1,
        score: 100,
        playedTime: 60,
      );

      expect(scoreBoard.level, equals(1));
      expect(scoreBoard.score, equals(100));
      expect(scoreBoard.playedTime, equals(60));
    });

    test('handles various game categories', () {
      final gameTypes = [
        GameCategoryType.CALCULATOR,
        GameCategoryType.GUESS_SIGN,
        GameCategoryType.MAGIC_TRIANGLE,
        GameCategoryType.MATH_PAIRS,
      ];

      for (int i = 0; i < gameTypes.length; i++) {
        final scoreBoard = ScoreBoard(
          gameCategoryType: gameTypes[i],
          level: i + 1,
          score: (i + 1) * 50,
          playedTime: (i + 1) * 30,
        );

        expect(scoreBoard.level, equals(i + 1));
        expect(scoreBoard.score, equals((i + 1) * 50));
        expect(scoreBoard.playedTime, equals((i + 1) * 30));
      }
    });

    test('handles edge cases for scores and time', () {
      final edgeCases = [
        {'score': 0, 'time': 0},
        {'score': 1, 'time': 1},
        {'score': 9999, 'time': 3600},
      ];

      for (final edgeCase in edgeCases) {
        final scoreBoard = ScoreBoard(
          gameCategoryType: GameCategoryType.CALCULATOR,
          level: 1,
          score: edgeCase['score'] as int,
          playedTime: edgeCase['time'] as int,
        );

        expect(scoreBoard.score, greaterThanOrEqualTo(0));
        expect(scoreBoard.playedTime, greaterThanOrEqualTo(0));
      }
    });
  });

  group('TrueFalse Model', () {
    test('creates true false instance with valid properties', () {
      final trueFalse = TrueFalse('5 + 3 = 8', true);

      expect(trueFalse.question, equals('5 + 3 = 8'));
      expect(trueFalse.answer, isTrue);
    });

    test('handles false statements correctly', () {
      final trueFalse = TrueFalse('2 + 2 = 5', false);

      expect(trueFalse.question, equals('2 + 2 = 5'));
      expect(trueFalse.answer, isFalse);
    });

    test('validates equation format', () {
      final equations = [
        '1 + 1 = 2',
        '10 - 5 = 5',
        '3 * 4 = 12',
        '8 / 2 = 4',
      ];

      for (final equation in equations) {
        final trueFalse = TrueFalse(equation, true);
        expect(trueFalse.question, contains('='));
        expect(trueFalse.question, matches(RegExp(r'\d+\s*[+\-*/]\s*\d+\s*=\s*\d+')));
      }
    });
  });
}
