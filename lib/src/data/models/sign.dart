import 'package:hive/hive.dart';

part 'sign.g.dart';

/// Model class representing a mathematical operation with two operands and a sign.
/// Used for basic arithmetic operations like addition, subtraction, multiplication, etc.
@HiveType(typeId: 63) // ⚠️ make sure this ID is unique in your project
class Sign {
  /// First operand in the mathematical expression
  @HiveField(0)
  final String firstDigit;

  /// Mathematical operator/sign (e.g., +, -, ×, ÷)
  @HiveField(1)
  final String sign;

  /// Second operand in the mathematical expression
  @HiveField(2)
  final String secondDigit;

  /// The result of the mathematical operation
  @HiveField(3)
  final String answer;

  /// Creates a new Sign instance.
  const Sign({
    required this.firstDigit,
    required this.sign,
    required this.secondDigit,
    required this.answer,
  });

  /// Creates a Sign from a JSON map
  factory Sign.fromJson(Map<String, dynamic> json) => Sign(
    firstDigit: json['firstDigit'] as String,
    sign: json['sign'] as String,
    secondDigit: json['secondDigit'] as String,
    answer: json['answer'] as String,
  );

  /// Converts the Sign instance to JSON
  Map<String, dynamic> toJson() => {
    'firstDigit': firstDigit,
    'sign': sign,
    'secondDigit': secondDigit,
    'answer': answer,
  };

  /// Creates a copy of Sign with updated values
  Sign copyWith({
    String? firstDigit,
    String? sign,
    String? secondDigit,
    String? answer,
  }) {
    return Sign(
      firstDigit: firstDigit ?? this.firstDigit,
      sign: sign ?? this.sign,
      secondDigit: secondDigit ?? this.secondDigit,
      answer: answer ?? this.answer,
    );
  }

  @override
  String toString() =>
      'Sign(firstDigit: $firstDigit, sign: $sign, secondDigit: $secondDigit, answer: $answer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Sign &&
              runtimeType == other.runtimeType &&
              firstDigit == other.firstDigit &&
              sign == other.sign &&
              secondDigit == other.secondDigit &&
              answer == other.answer;

  @override
  int get hashCode =>
      firstDigit.hashCode ^ sign.hashCode ^ secondDigit.hashCode ^ answer.hashCode;
}