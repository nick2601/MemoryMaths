import 'dart:math';
import 'RandomFindMissingData.dart';
import 'models/true_false_model.dart';

/// Constants for true/false values
const String strFalse = "false";
const String strTrue = "true";

/// A class that generates random mathematical problems and solutions.
/// Supports addition, subtraction, multiplication, and division.
class RandomOptionData {
  final int levelNo;
  late final int dataTypeNumber;
  final Random _random = Random();

  int firstDigit = 0;
  int secondDigit = 0;
  int answer = 0;
  double doubleAnswer = 0;

  String? question;
  String currentSign = "+";

  bool isTrueFalseQuiz = false;

  RandomOptionData(this.levelNo)
      : dataTypeNumber = (levelNo <= 10)
      ? 1
      : (levelNo <= 20)
      ? 2
      : 3;

  void setTrueFalseQuiz(bool value) {
    isTrueFalseQuiz = value;
  }

  // ---------- Public Entry ----------
  TrueFalseModel getMethods() {
    switch (_random.nextInt(4)) {
      case 0:
        currentSign = "+";
        return getAddition();
      case 1:
        currentSign = "-";
        return getSubtraction();
      case 2:
        currentSign = "×";
        return getMultiplication();
      case 3:
      default:
        currentSign = "÷";
        return getDivision();
    }
  }

  // ---------- Operations ----------
  TrueFalseModel getAddition() {
    firstDigit = _randomInRange(getFirstMinNumber(), getFirstMaxNumber());
    secondDigit = _randomInRange(getSecondMinNumber(), getSecondMaxNumber());
    answer = firstDigit + secondDigit;
    return _buildModel(answer, isDouble: false);
  }

  TrueFalseModel getSubtraction() {
    firstDigit = _randomInRange(getFirstMinNumber(), getFirstMaxNumber());
    secondDigit = _randomInRange(getSecondMinNumber(), getSecondMaxNumber());

    if (secondDigit > firstDigit) {
      final tmp = firstDigit;
      firstDigit = secondDigit;
      secondDigit = tmp;
    }

    answer = firstDigit - secondDigit;
    return _buildModel(answer, isDouble: false);
  }

  TrueFalseModel getMultiplication() {
    firstDigit = dataTypeNumber == 1 ? _randomInRange(1, 5) : _randomInRange(5, 30);
    secondDigit = dataTypeNumber == 1 ? _randomInRange(1, 5) : _randomInRange(5, 30);
    answer = firstDigit * secondDigit;
    return _buildModel(answer, isDouble: false);
  }

  TrueFalseModel getDivision() {
    secondDigit = _randomInRange(2, 12);
    answer = _randomInRange(2, 20);
    firstDigit = secondDigit * answer;

    doubleAnswer = firstDigit / secondDigit;
    return _buildModel(doubleAnswer, isDouble: true);
  }

  // ---------- Build TrueFalseModel ----------
  TrueFalseModel _buildModel(num correct, {required bool isDouble}) {
    // Build question
    question ??= "$firstDigit $currentSign $secondDigit";

    if (!isTrueFalseQuiz) {
      final options = isDouble
          ? _generateDoubleOptions(correct.toDouble())
          : _generateOptions(correct.toInt());

      return TrueFalseModel(
        answer: isDouble ? _formatDouble(correct.toDouble()) : correct.toString(),
        question: "$question = ?",
      )..optionList = options;
    } else {
      // Pick random wrong/right answer
      final options = isDouble
          ? _generateDoubleOptions(correct.toDouble())
          : _generateOptions(correct.toInt());

      final isCorrect = _random.nextBool();
      final chosenAnswer = isCorrect
          ? correct
          : (isDouble ? double.parse(options.first) : int.parse(options.first));

      return TrueFalseModel(
        answer: isCorrect ? strTrue : strFalse,
        question:
        "$question = ${isDouble ? _formatDouble(chosenAnswer.toDouble()) : chosenAnswer.toString()}",
      )..optionList = options;
    }
  }

  // ---------- Option Generators ----------
  List<String> _generateOptions(int correct) {
    final set = <int>{correct};
    while (set.length < 4) {
      set.add(correct + _random.nextInt(21) - 10);
    }
    return set.map((e) => e.toString()).toList()..shuffle();
  }

  List<String> _generateDoubleOptions(double correct) {
    final set = <String>{_formatDouble(correct)};
    while (set.length < 4) {
      final variation = correct + (_random.nextDouble() * 10 - 5);
      set.add(_formatDouble(variation));
    }
    return set.toList()..shuffle();
  }

  String _formatDouble(double value) =>
      value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);

  // ---------- Helpers ----------
  int _randomInRange(int min, int max) => _random.nextInt(max - min + 1) + min;

  int getFirstMinNumber() => dataTypeNumber == 1 ? 10 : (dataTypeNumber == 2 ? 50 : 200);
  int getFirstMaxNumber() => dataTypeNumber == 1 ? 50 : (dataTypeNumber == 2 ? 200 : 500);
  int getSecondMinNumber() => dataTypeNumber == 1 ? 30 : (dataTypeNumber == 2 ? 50 : 100);
  int getSecondMaxNumber() => dataTypeNumber == 1 ? 100 : (dataTypeNumber == 2 ? 250 : 500);
}
