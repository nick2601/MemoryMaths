import 'package:mathsgames/src/data/RandomFindMissingData.dart';
import 'package:mathsgames/src/data/models/numeric_memory_answer_pair.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/utility/math_util.dart';

class NumericMemoryRepository {
  static List<int> listHasCode = <int>[];

  static getNumericMemoryDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    int totalPairs = level <= 2 ? 12 : 18;

    List<NumericMemoryPair> memoryList = <NumericMemoryPair>[];

    while (memoryList.length < 1) {
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (memoryList.length ~/ 2))
          .forEach((Expression expression) {
        if (expression.answer > 0) {
          NumericMemoryPair numericMemoryPair = new NumericMemoryPair();
          numericMemoryPair.question = expression.answer;
          numericMemoryPair.answer =
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}";

          List<NumericMemoryAnswerPair> list = [];

          list.add(getModel(
              "${expression.firstOperand} + ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} - ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} / ${expression.secondOperand}"));
          list.add(getModel(
              "${expression.firstOperand} * ${expression.secondOperand}"));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));
          list.add(getModel(""));

          shuffle(list);
          shuffle(list);

          numericMemoryPair.list = list;

          memoryList.add(numericMemoryPair);
        }

        //     print("operand==${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}");
        //
        // Pair mathPair1 = Pair(
        //     i,
        //     "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
        //     false,
        //     true);
        //
        // Pair mathPair2 = Pair(i, "${expression.answer}", false, true);
        //
        // if (!list.contains(mathPair2) &&
        //     !listHasCode.contains(mathPair1.hashCode)) {
        //   list.add(mathPair1);
        //   list.add(mathPair2);
        //   listHasCode.add(mathPair1.hashCode);
        //   i++;
        // }
      });
    }

    // list.shuffle();
    return memoryList;
    // return <MathPairs>[MathPairs(list, totalPairs)];
  }

  static NumericMemoryAnswerPair getModel(String s) {
    NumericMemoryAnswerPair model = new NumericMemoryAnswerPair();
    model.key = s;
    return model;
  }
}

void main() {
  for (int i = 1; i < 6; i++) {
    NumericMemoryRepository.getNumericMemoryDataList(i);
  }
}
