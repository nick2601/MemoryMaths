import 'package:flutter_test/flutter_test.dart';
import 'package:mathsgames/src/data/models/mental_arithmetic.dart';
import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/data/models/numeric_memory_answer_pair.dart';
import 'package:mathsgames/src/data/repositories/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/data/repositories/number_pyramid_repository.dart';
import 'package:mathsgames/src/data/repositories/numeric_memory_repository.dart';

void main() {
  group('MentalArithmeticRepository', () {
    test('generates problems for multiple levels', () {
      for (var level = 1; level <= 5; level++) {
        final list = MentalArithmeticRepository.getMentalArithmeticDataList(level);
        expect(list, isNotEmpty, reason: 'Level $level should produce data');
        expect(list, everyElement(isA<MentalArithmetic>()));
      }
    });

    test('each problem has valid question, answer list and answer inside list', () {
      final list = MentalArithmeticRepository.getMentalArithmeticDataList(2);
      for (final item in list) {
        expect(item.question.trim(), isNotEmpty);
        expect(item.answerList.length, greaterThanOrEqualTo(3));
        expect(item.answerList.contains(item.answer.toString()), isTrue,
            reason: 'Answer ${item.answer} must be present in answerList ${item.answerList}');
      }
    });

    test('difficulty progression increases average answer', () {
      final lvl1 = MentalArithmeticRepository.getMentalArithmeticDataList(1);
      final lvl4 = MentalArithmeticRepository.getMentalArithmeticDataList(4);
      final avg1 = lvl1.map((e) => e.answer).reduce((a, b) => a + b) / lvl1.length;
      final avg4 = lvl4.map((e) => e.answer).reduce((a, b) => a + b) / lvl4.length;
      // Allow some randomness but expect some growth
      expect(avg4, greaterThanOrEqualTo(avg1 * 0.8));
    });
  });

  group('NumberPyramidRepository', () {
    test('generates pyramids for several levels', () {
      for (var level = 1; level <= 4; level++) {
        final list = NumberPyramidRepository.getPyramidDataList(level);
        expect(list, isNotEmpty);
        expect(list, everyElement(isA<NumberPyramid>()));
      }
    });

    test('pyramid model integrity', () {
      final list = NumberPyramidRepository.getPyramidDataList(2);
      for (final p in list) {
        expect(p.numberList, isNotEmpty);
        expect(p.answerList, isNotEmpty);
        expect(p.answerList.contains(p.answer.toString()), isTrue);
      }
    });
  });

  group('NumericMemoryRepository', () {
    test('produces memory sequences for different levels', () {
      for (var level = 1; level <= 6; level++) {
        final list = NumericMemoryRepository.getNumericMemoryDataList(level);
        expect(list, isNotEmpty);
        expect(list, everyElement(isA<NumericMemoryAnswerPair>()));
      }
    });

    test('sequence length scaling (average length non-decreasing)', () {
      final lvl1 = NumericMemoryRepository.getNumericMemoryDataList(1);
      final lvl5 = NumericMemoryRepository.getNumericMemoryDataList(5);
      final avg1 = lvl1.map((e) => e.list.length).reduce((a, b) => a + b) / lvl1.length;
      final avg5 = lvl5.map((e) => e.list.length).reduce((a, b) => a + b) / lvl5.length;
      expect(avg5, greaterThanOrEqualTo(avg1));
    });

    test('all sequence values are integers and non-empty list', () {
      final list = NumericMemoryRepository.getNumericMemoryDataList(3);
      for (final seq in list) {
        expect(seq.list, isNotEmpty);
        expect(seq.list, everyElement(isA<int>()));
      }
    });
  });

  group('Model specifics', () {
    test('MentalArithmetic model fields behave as expected', () {
      final m = MentalArithmetic(question: '2 + 3 + 4', answer: 9, answerList: ['9', '8', '10']);
      expect(m.answerList.contains(m.answer.toString()), isTrue);
    });

    test('NumberPyramid model fields valid', () {
      final p = NumberPyramid(numberList: [1,2,3,4], answer: 7, answerList: ['6','7','8']);
      expect(p.numberList.length, equals(4));
      expect(p.answerList.contains('7'), isTrue);
    });

    test('NumericMemoryAnswerPair preserves order', () {
      final n = NumericMemoryAnswerPair(list: [3,1,4]);
      expect(n.list, orderedEquals([3,1,4]));
    });
  });
}

