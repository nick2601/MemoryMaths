import 'dart:math';
import 'models/quiz_model.dart';

/// A class that generates random mathematical problems for quizzes.
/// Supports addition, subtraction, multiplication, division,
/// squares, square roots, and cube operations.
class RandomDualData {
  final int levelNo;
  final Random _random = Random();

  // Operands and answers
  late int firstDigit;
  late int secondDigit;
  late int answer;
  late double doubleAnswer;

  // Question text
  String? question;

  // Signs
  final String additionSign = "+";
  final String subtractionSign = "-";
  final String multiplicationSign = "×";
  final String divisionSign = "÷";
  final String equalSign = "=";

  RandomDualData(this.levelNo);

  // ---------- Difficulty Ranges ----------
  int getFirstMinNumber() => (levelNo == 1) ? 10 : (levelNo == 2 ? 150 : 200);
  int getFirstMaxNumber() => (levelNo == 1) ? 50 : (levelNo == 2 ? 200 : 500);
  int getSecondMinNumber() => (levelNo == 1) ? 50 : (levelNo == 2 ? 200 : 300);
  int getSecondMaxNumber() => (levelNo == 1) ? 100 : (levelNo == 2 ? 250 : 500);

  // ---------- Option Generators ----------
  List<int> _generateOptions(int correct) {
    final set = <int>{correct};
    while (set.length < 4) {
      set.add(correct + _random.nextInt(21) - 10); // ±10 variation
    }
    return set.toList()..shuffle();
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

  // ---------- Random Method Selector ----------
  QuizModel getRandomQuestion() {
    switch (_random.nextInt(4)) {
      case 0:
        return getAddition();
      case 1:
        return getSubtraction();
      case 2:
        return getMultiplication();
      case 3:
        return getDivision();
      default:
        return getAddition();
    }
  }

  // ---------- Operations ----------
  QuizModel getAddition() {
    firstDigit = _randomInRange(getFirstMinNumber(), getFirstMaxNumber());
    secondDigit = _randomInRange(getSecondMinNumber(), getSecondMaxNumber());

    answer = firstDigit + secondDigit;
    question = "$firstDigit $additionSign $secondDigit $equalSign ?";

    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getSubtraction() {
    firstDigit = _randomInRange(getFirstMinNumber(), getFirstMaxNumber());
    secondDigit = _randomInRange(getSecondMinNumber(), getSecondMaxNumber());

    // Ensure no negative answers
    if (secondDigit > firstDigit) {
      final temp = firstDigit;
      firstDigit = secondDigit;
      secondDigit = temp;
    }

    answer = firstDigit - secondDigit;
    question = "$firstDigit $subtractionSign $secondDigit $equalSign ?";

    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getMultiplication() {
    firstDigit = (levelNo == 1) ? _random.nextInt(5) + 1 : _randomInRange(5, 20);
    secondDigit =
    (levelNo == 1) ? _random.nextInt(5) + 1 : _randomInRange(5, 20);

    answer = firstDigit * secondDigit;
    question = "$firstDigit $multiplicationSign $secondDigit $equalSign ?";

    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getDivision() {
    // Force integer division
    secondDigit = _randomInRange(2, 12);
    answer = _randomInRange(2, 20);
    firstDigit = secondDigit * answer;

    question = "$firstDigit $divisionSign $secondDigit $equalSign ?";

    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getSquare() {
    firstDigit = _randomInRange(2, 20);
    answer = firstDigit * firstDigit;

    question = "$firstDigit² $equalSign ?";
    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getSquareRoot() {
    answer = _randomInRange(2, 20);
    firstDigit = answer * answer;

    question = "√$firstDigit $equalSign ?";
    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  QuizModel getCube() {
    firstDigit = _randomInRange(2, 10);
    answer = pow(firstDigit, 3).toInt();

    question = "$firstDigit³ $equalSign ?";
    final options = _generateOptions(answer).map((e) => e.toString()).toList();
    return QuizModel(answer: answer.toString(), question: question, optionList: options);
  }

  // ---------- Helper ----------
  int _randomInRange(int min, int max) => _random.nextInt(max - min + 1) + min;
}