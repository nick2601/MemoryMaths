import 'dart:math';
import 'package:intl/intl.dart';
import 'models/find_missing_model.dart';

/// Generates random math problems for a "find the missing number" game.
/// Supports addition, subtraction, multiplication, and division.
class RandomFindMissingData {
  final int levelNo;
  late final int dataTypeNumber;
  final Random _random = Random();

  int firstDigit = 0;
  int secondDigit = 0;
  int answer = 0;
  double doubleAnswer = 0;

  double firstDoubleDigit = 0;
  double secondDoubleDigit = 0;

  String currentSign = "+";
  String? question;
  int helpTag = 0;

  RandomFindMissingData(this.levelNo)
      : dataTypeNumber = (levelNo <= 5)
      ? 1
      : (levelNo <= 20)
      ? 2
      : 3;

  // ---------- Ranges ----------
  int getFirstMinNumber() => dataTypeNumber == 1 ? 10 : (dataTypeNumber == 2 ? 150 : 200);
  int getFirstMaxNumber() => dataTypeNumber == 1 ? 50 : (dataTypeNumber == 2 ? 200 : 500);
  int getSecondMinNumber() => dataTypeNumber == 1 ? 50 : (dataTypeNumber == 2 ? 200 : 300);
  int getSecondMaxNumber() => dataTypeNumber == 1 ? 100 : (dataTypeNumber == 2 ? 250 : 500);

  // ---------- Public Entry ----------
  FindMissingQuizModel getMethods() {
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
  FindMissingQuizModel getAddition() {
    firstDigit = _randomInRange(getFirstMinNumber(), getFirstMaxNumber());
    secondDigit = _randomInRange(getSecondMinNumber(), getSecondMaxNumber());
    answer = firstDigit + secondDigit;
    return _buildModel(answer, isDouble: false);
  }

  FindMissingQuizModel getSubtraction() {
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

  FindMissingQuizModel getMultiplication() {
    firstDigit = dataTypeNumber == 1 ? _randomInRange(1, 5) : _randomInRange(5, 20);
    secondDigit = dataTypeNumber == 1 ? _randomInRange(1, 5) : _randomInRange(5, 20);
    answer = firstDigit * secondDigit;
    return _buildModel(answer, isDouble: false);
  }

  FindMissingQuizModel getDivision() {
    // Ensure integer division
    secondDigit = _randomInRange(2, 12);
    answer = _randomInRange(2, 20);
    firstDigit = secondDigit * answer;

    doubleAnswer = firstDigit / secondDigit;
    return _buildModel(doubleAnswer, isDouble: true);
  }

  // ---------- Build QuizModel ----------
  FindMissingQuizModel _buildModel(num correct, {required bool isDouble}) {
    helpTag = _random.nextInt(3) + 1; // Decide where '?' goes

    // Build question text
    switch (helpTag) {
      case 1:
        question = "? $currentSign $secondDigit = $correct";
        break;
      case 2:
        question = "$firstDigit $currentSign ? = $correct";
        break;
      default:
        question = "$firstDigit $currentSign $secondDigit = ?";
    }

    // Generate options
    final options = isDouble
        ? _generateDoubleOptions(correct.toDouble())
        : _generateOptions(correct.toInt());

    return FindMissingQuizModel(
      question: question,
      answer: isDouble ? _formatDouble(correct.toDouble()) : correct.toString(),
      optionList: options,
    );
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
}