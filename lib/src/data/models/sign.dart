/// Model class representing a mathematical operation with two operands and a sign.
/// Used for basic arithmetic operations like addition, subtraction, multiplication, etc.
class Sign {
  /// First operand in the mathematical expression
  String firstDigit;

  /// Mathematical operator/sign (e.g., +, -, ×, ÷)
  String sign;

  /// Second operand in the mathematical expression
  String secondDigit;

  /// The result of the mathematical operation
  String answer;

  /// Creates a new Sign instance.
  ///
  /// Parameters:
  /// - [firstDigit]: First number in the expression
  /// - [sign]: Mathematical operator
  /// - [secondDigit]: Second number in the expression
  /// - [answer]: Result of the operation
  Sign({
    required this.firstDigit,
    required this.sign,
    required this.secondDigit,
    required this.answer,
  });

  @override
  String toString() {
    return 'SignQandS{firstDigit: $firstDigit, sign: $sign, secondDigit: $secondDigit, answer: $answer} \n';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sign &&
          runtimeType == other.runtimeType &&
          firstDigit == other.firstDigit &&
          sign == other.sign &&
          secondDigit == other.secondDigit;

  @override
  int get hashCode =>
      firstDigit.hashCode ^ sign.hashCode ^ secondDigit.hashCode;
}
