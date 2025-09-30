import 'dart:math';

import 'package:mathsgames/src/data/models/random_find_missing_data.dart';

import 'true_false_model.dart';

/// Constants for true/false string values
String strFalse = "false";
String strTrue = "true";

/// A class that generates random mathematical problems and their solutions
/// for different difficulty levels and operation types (addition, subtraction,
/// multiplication, division)
class RandomOptionData {
  // Basic properties for calculations
  int levelNo = 0;
  int firstDigit = 0;
  int secondDigit = 0;
  int answer = 0;
  double doubleAnswer = 0;

  // Question formatting properties
  String? question, tableName;
  String? multiplicationSign,
      space,
      additionSign,
      subtractionSign,
      divisionSign;

  /// Determines difficulty level of questions:
  /// 1: Easy (levels 1-10)
  /// 2: Medium (levels 11-20)
  /// 3: Hard (levels 21-30)
  int? dataTypeNumber = 1;

  /// Tracks current mathematical operation being used
  String currentSign = "+";

  /// Constructor initializes the object with a specific level number
  /// and sets up the mathematical operators
  RandomOptionData(int levelNo) {
    this.levelNo = levelNo;
    if (levelNo > 10 && levelNo <= 20) {
      dataTypeNumber = 2;
    } else if (levelNo > 20 && levelNo <= 30) {
      dataTypeNumber = 3;
    }

    additionSign = "+";
    multiplicationSign = "*";
    divisionSign = "/";
    subtractionSign = "-";
    space = "\u0020";
  }

  /// Flag to determine if questions should be generated in true/false format
  bool isTrueFalseQuiz = false;

  void setTrueFalseQuiz(bool isTrueFalseQuiz) {
    this.isTrueFalseQuiz = isTrueFalseQuiz;
  }

  /// Randomly selects and returns a mathematical operation
  /// Returns a TrueFalseModel containing the problem and its solution
  TrueFalseModel getMethods() {
    int i = new Random().nextInt((4 - 1) + 1) + 1;
    currentSign = additionSign!;
    if (i == 1) {
      currentSign = additionSign!;
      return getAddition();
    } else if (i == 2) {
      currentSign = subtractionSign!;
      return getSubtraction();
    } else if (i == 3) {
      currentSign = multiplicationSign!;
      return getMultiplication();
    } else if (i == 4) {
      currentSign = divisionSign!;
      return getDivision();
    }
    return getAddition();
  }

  /// Generates an addition problem based on the current difficulty level
  TrueFalseModel getAddition() {
    int firstMin = getFirstMinNumber();
    int secondMin = getSecondMinNumber();
    int firstMax = getFirstMaxNumber();
    int secondMax = getSecondMaxNumber();

    firstDigit = new Random().nextInt((firstMax - firstMin) + 1) + firstMin;
    secondDigit = new Random().nextInt((secondMax - secondMin) + 1) + secondMin;

    answer = firstDigit + secondDigit;

    return addModel();
  }

  /// Generates a subtraction problem with numbers appropriate for the current level
  TrueFalseModel getSubtraction() {
    if (dataTypeNumber == 1) {
      firstDigit = new Random().nextInt(50) + 10;
      secondDigit = new Random().nextInt(30) + 3;
    } else if (dataTypeNumber == 2) {
      firstDigit = new Random().nextInt((100 - 50) + 1) + 50;
      secondDigit = new Random().nextInt((50 - 10) + 1) + 10;
    } else {
      firstDigit = new Random().nextInt((500 - 200) + 1) + 200;
      secondDigit = new Random().nextInt((200 - 100) + 1) + 100;
    }

    answer = firstDigit - secondDigit;

    return addModel();
  }

  /// Creates a multiplication problem with difficulty-appropriate factors
  TrueFalseModel getMultiplication() {
    if (dataTypeNumber == 1) {
      firstDigit = new Random().nextInt(5) + 1;
      secondDigit = new Random().nextInt(5) + 1;
    } else if (dataTypeNumber == 2) {
      firstDigit = new Random().nextInt(30) + 1;
      secondDigit = new Random().nextInt(30) + 1;
    } else {
      firstDigit = new Random().nextInt(80) + 5;
      secondDigit = new Random().nextInt(30) + 5;
    }

    answer = firstDigit * secondDigit;

    return addModel();
  }

  /// Generates a division problem that results in a decimal answer
  TrueFalseModel getDivision() {
    double n1, n2;

    if (dataTypeNumber == 1) {
      n1 = new Random().nextInt((40 - 10) + 1) + 5;
      n2 = new Random().nextInt((10 - 5) + 1) + 5;
    } else if (dataTypeNumber == 2) {
      n1 = new Random().nextInt((100 - 50) + 1) + 50;
      n2 = new Random().nextInt((10 - 5) + 1) + 5;
    } else {
      n1 = new Random().nextInt((200 - 100) + 1) + 100;
      n2 = new Random().nextInt((100 - 50) + 1) + 50;
    }

    doubleAnswer = n1 / n2;

    firstDigit = n1.toInt();
    secondDigit = n2.toInt();

    return addDoubleModel();
  }

  /// Creates a complex division problem involving multiple operations
  /// Returns a problem in the format: n1 + (±n2 / n3)
  TrueFalseModel getComplicatedDivision() {
    Random random = new Random();
    double n1, n2, n3;
    int operator = (random.nextDouble() * 2).toInt() + 1;

    bool isMinus = operator == 1;

    if (dataTypeNumber == 1) {
      n1 = random.nextInt(20) + 1;
      n2 = random.nextInt(15) + 1;
      n3 = random.nextInt(5) + 1;
    } else if (dataTypeNumber == 2) {
      n1 = random.nextInt(50) + 1;
      n2 = random.nextInt(40) + 1;
      n3 = random.nextInt(20) + 1;
    } else {
      n1 = random.nextInt(200) + 1;
      n2 = random.nextInt(150) + 1;
      n3 = random.nextInt(100) + 1;
    }

    if (isMinus) {
      doubleAnswer = n1 + ((-n2) / n3);
      question = n1.toInt().toString() +
          space! +
          additionSign! +
          space! +
          "(" +
          "(" +
          subtractionSign! +
          n2.toInt().toString() +
          ")" +
          space! +
          divisionSign! +
          space! +
          n3.toInt().toString() +
          ")";
    } else {
      doubleAnswer = n1 + (n2 / n3);

      question = n1.toInt().toString() +
          space! +
          additionSign! +
          space! +
          "(" +
          n2.toInt().toString() +
          space! +
          divisionSign! +
          space! +
          n3.toInt().toString() +
          ")";
    }

    return addDoubleModel();
  }

  /// Helper methods to determine number ranges based on difficulty level
  int getFirstMinNumber() {
    int number = 30;
    if (dataTypeNumber == 1) {
      number = 10;
    } else if (dataTypeNumber == 2) {
      number = 150;
    }

    return number;
  }

  int getFirstMaxNumber() {
    int number = 50;

    if (dataTypeNumber == 1) {
      number = 50;
    } else if (dataTypeNumber == 2) {
      number = 200;
    }

    return number;
  }

  int getSecondMaxNumber() {
    int number = 150;

    if (dataTypeNumber == 1) {
      number = 100;
    } else if (dataTypeNumber == 2) {
      number = 250;
    }

    return number;
  }

  int getSecondMinNumber() {
    int number = 150;

    if (dataTypeNumber == 1) {
      number = 50;
    } else if (dataTypeNumber == 2) {
      number = 200;
    }
    return number;
  }

  /// Creates a TrueFalseModel with the correct answer and three wrong options
  /// If isTrueFalseQuiz is true, generates a true/false question instead
  TrueFalseModel addModel() {
    int op_1 = answer + 10;
    int op_2 = answer - 10;
    if (op_2 < 0) {
      op_2 = answer + 15;
    }

    int op_3 = answer + 20;
    List<String> stringList = [];
    stringList.add(op_1.toString());
    stringList.add(op_2.toString());
    stringList.add(op_3.toString());
    stringList.add(answer.toString());

    TrueFalseModel trueFalseModel;

    if (!isTrueFalseQuiz) {
      if (question == null || question!.isEmpty) {
        trueFalseModel = new TrueFalseModel(
          answer.toString(),
          firstDigit: firstDigit.toString(),
          secondDigit: secondDigit.toString(),
          op_1: op_1.toString(),
          op_2: op_2.toString(),
          op_3: op_3.toString(),
        );
      } else {
        trueFalseModel = new TrueFalseModel(
          answer.toString(),
          question: question,
          op_1: op_1.toString(),
          op_2: op_2.toString(),
          op_3: op_3.toString(),
        );
      }
    } else {
      int helpTag = new Random().nextInt(4) + 1;
      int ans;
      String s, stringAnswer;
      stringAnswer = strFalse;
      if (helpTag == 1) {
        ans = op_1;
      } else if (helpTag == 2) {
        ans = op_2;
      } else if (helpTag == 3) {
        ans = op_3;
      } else {
        stringAnswer = strTrue;

        ans = answer;
      }

      if (question == null || question!.isEmpty) {
        s = firstDigit.toString() +
            " " +
            currentSign +
            " " +
            secondDigit.toString() +
            " = " +
            ans.toString();
      } else {
        s = question! + " = " + ans.toString();
      }

      trueFalseModel = new TrueFalseModel(stringAnswer, question: s);
    }
    shuffle(stringList);
    trueFalseModel.optionList = (stringList);
    return trueFalseModel;
  }

  /// Similar to addModel() but handles decimal answers from division operations
  TrueFalseModel addDoubleModel() {
    double opDouble1 = doubleAnswer + 10;
    double opDouble2 = doubleAnswer - 10;

    if (opDouble2 < 0) {
      opDouble2 = doubleAnswer + 15;
    }
    double opDouble3 = doubleAnswer + 20;
    List<String> stringList = [];
    stringList.add(getFormattedString(opDouble1));
    stringList.add(getFormattedString(opDouble2));
    stringList.add(getFormattedString(opDouble3));
    stringList.add(getFormattedString(doubleAnswer));

    TrueFalseModel trueFalseModel;

    if (!isTrueFalseQuiz) {
      if (question == null || question!.isEmpty) {
        trueFalseModel = new TrueFalseModel(
          getFormattedString(doubleAnswer),
          firstDigit: firstDigit.toString(),
          secondDigit: secondDigit.toString(),
          op_1: opDouble1.toString(),
          op_2: opDouble2.toString(),
          op_3: opDouble3.toString(),
        );
      } else {
        trueFalseModel = new TrueFalseModel(
          getFormattedString(doubleAnswer),
          question: question,
          op_1: opDouble1.toString(),
          op_2: opDouble2.toString(),
          op_3: opDouble3.toString(),
        );
      }
    } else {
      int helpTag = new Random().nextInt(4) + 1;
      double ans;
      String s, stringAnswer;
      stringAnswer = strFalse;
      if (helpTag == 1) {
        ans = opDouble1;
      } else if (helpTag == 2) {
        ans = opDouble2;
      } else if (helpTag == 3) {
        ans = opDouble3;
      } else {
        ans = doubleAnswer;
        stringAnswer = strTrue;
      }

      if (question == null || question!.isEmpty) {
        s = firstDigit.toString() +
            " " +
            currentSign +
            " " +
            secondDigit.toString() +
            " = " +
            getFormattedString(ans);
      } else {
        s = question! + " = " + getFormattedString(ans);
      }

      trueFalseModel = new TrueFalseModel(stringAnswer, question: s);
    }
    shuffle(stringList);
    trueFalseModel.optionList = (stringList);
    return trueFalseModel;
  }
}
