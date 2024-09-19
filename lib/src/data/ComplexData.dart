import 'dart:math';

import 'package:mathsgames/src/data/RandomFindMissingData.dart';
import 'package:mathsgames/src/data/models/ComplexModel.dart';

class ComplexData {
  String? question;
  String? answerString;
  String? sign;
  String? randomSign;
  int finalAnswer = 0;
  int answer = 0;
  int n1 = 0;
  int n2 = 0;
  int n3 = 0;
  int op_1 = 0;
  int op_2 = 0;
  int op_3 = 0;
  int value1 = 0;
  int value2 = 0;

  static ComplexModel getComplexValues(int type) {
    int operator = new Random().nextInt(2) + 1;
    bool isMinus = operator == 1;

    String? question;
    String? answerString;

    String? randomSign;

    int finalAnswer = 0;
    int answer = 0;
    int n1 = 0;
    int n2 = 0;
    int n3 = 0;
    int op_1 = 0;
    int op_2 = 0;
    int op_3 = 0;

    List<int> randomValues = getAdditionRandomValues(type);

    n1 = randomValues[0];
    n2 = randomValues[1];
    n3 = randomValues[2];
    String sign;
    String signQuestion = "?";
    String signEqual = "=";
    if (isMinus) {
      sign = "+";
      answer = n1 + n2;
    } else {
      sign = "-";
      answer = n1 - n2;
      n3 = n3;
    }
    String space = "\u0020";
    operator = new Random().nextInt(2) + 1;

    isMinus = operator == 1;

    if (isMinus) {
      randomSign = "+";
      answer = answer + n3;
    } else {
      randomSign = "-";
      answer = answer - n3;
      n3 = n3;
    }

    finalAnswer = n3;
    question = n1.toString() +
        space +
        sign +
        space +
        n2.toString() +
        space +
        randomSign +
        space +
        signQuestion +
        space +
        signEqual +
        space +
        answer.toString();

    answerString = n1.toString() +
        space +
        sign +
        space +
        n2.toString() +
        space +
        randomSign +
        space +
        finalAnswer.toString() +
        space +
        signEqual +
        space +
        answer.toString();

    op_1 = finalAnswer + 10;
    op_2 = finalAnswer - 10;
    op_3 = finalAnswer - 8;
    // String[] ar = new String[9];

    ComplexModel complexModel = new ComplexModel();

    complexModel.question = question;
    complexModel.answer = answerString;
    complexModel.finalAnswer = finalAnswer.toString();

    List<String> optionList = [];
    optionList.add(op_1.toString());
    optionList.add(op_2.toString());
    optionList.add(op_3.toString());
    optionList.add(finalAnswer.toString());

    shuffle(optionList);
    complexModel.optionList = optionList;

    // ar[0] = String.valueOf(finalAnswer);
    // ar[1] = question;
    // ar[2] = String.valueOf(op_1);
    // ar[3] = String.valueOf(op_2);
    // ar[4] = String.valueOf(op_3);
    // ar[5] = String.valueOf(n1);
    // ar[6] = String.valueOf(n2);
    // ar[7] = sign;
    // ar[8] = answerString;

    return complexModel;
  }

  static List<int> getAdditionRandomValues(int type) {
    Random random = new Random();

    int n1 = 0, n2 = 0, n3 = 0;
    if (type == 1) {
      n1 = random.nextInt(40) + 1;
      n2 = random.nextInt(40) + 1;
      n3 = random.nextInt(40) + 1;
    } else if (type == 2) {
      n1 = random.nextInt(1000 - 100 + 1) + 90;
      n2 = random.nextInt(500 + 50) + 1;
      n3 = random.nextInt(500 + 50) + 1;
    } else if (type == 3) {
      n1 = random.nextInt(2000 - 500 + 1) + 500;
      n2 = random.nextInt(1000 - 200) + 1;
      n3 = random.nextInt(1000 - 200) + 1;
    }

    List<int> list = [];
    list.add(n1);
    list.add(n2);
    list.add(n3);

    return list;
  }
}
