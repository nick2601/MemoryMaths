import 'dart:math';


import 'models/ComplexModel.dart';

/// A utility class for generating complex math equations for quiz-style games.
///
/// Generates equations like:
///   n1 (+/-) n2 (+/-) ? = answer
class ComplexData {
  /// Generates a complex math equation with random values.
  ///
  /// [type] defines difficulty:
  /// - 1 = Easy (small numbers)
  /// - 2 = Medium
  /// - 3 = Hard
  ///
  /// Returns a [ComplexModel] with question, answer string, and options.
  static ComplexModel getComplexValues(int type) {
    final random = Random();

    // Generate base numbers depending on difficulty
    final randomValues = getAdditionRandomValues(type);
    int n1 = randomValues[0];
    int n2 = randomValues[1];
    int n3 = randomValues[2];

    // First operator (+ or -)
    bool isAddition = random.nextBool();
    String sign = isAddition ? "+" : "-";
    int answer = isAddition ? n1 + n2 : n1 - n2;

    // Second operator (+ or -)
    bool isSecondAddition = random.nextBool();
    String randomSign = isSecondAddition ? "+" : "-";
    answer = isSecondAddition ? answer + n3 : answer - n3;

    final int finalAnswer = n3;
    const String missing = "?";
    const String equal = "=";
    const String space = " ";

    // Question with missing value
    final question = "$n1 $sign $n2 $randomSign $missing $equal $answer";

    // Answer string with the finalAnswer filled in
    final answerString = "$n1 $sign $n2 $randomSign $finalAnswer $equal $answer";

    // Multiple choice options
    final options = [
      finalAnswer.toString(),
      (finalAnswer + 10).toString(),
      (finalAnswer - 10).toString(),
      (finalAnswer - 8).toString(),
    ]..shuffle();

    return ComplexModel(
      question: question,
      finalAnswer: finalAnswer.toString(),
      answer: answerString,
      optionList: options,
    );
  }

  /// Generates random numbers depending on difficulty level.
  ///
  /// - Type 1 (Easy): n1, n2, n3 between 1–40
  /// - Type 2 (Medium): n1 between 90–1000, n2/n3 between 1–550
  /// - Type 3 (Hard): n1 between 500–2000, n2/n3 between 1–800
  static List<int> getAdditionRandomValues(int type) {
    final random = Random();

    switch (type) {
      case 1: // Easy
        return [
          random.nextInt(40) + 1,
          random.nextInt(40) + 1,
          random.nextInt(40) + 1,
        ];
      case 2: // Medium
        return [
          random.nextInt(911) + 90, // 90–1000
          random.nextInt(551) + 1, // 1–550
          random.nextInt(551) + 1,
        ];
      case 3: // Hard
        return [
          random.nextInt(1501) + 500, // 500–2000
          random.nextInt(801) + 1, // 1–800
          random.nextInt(801) + 1,
        ];
      default:
        throw ArgumentError("Invalid type: $type. Use 1, 2, or 3.");
    }
  }
}