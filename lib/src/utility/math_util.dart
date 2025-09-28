import 'dart:math';

/// Utility class providing math expression generation and evaluation.
class MathUtil {
  static final Random _random = Random();

  /// Evaluates a binary operation between two integers.
  static int evaluate(int x1, String sign, int x2) {
    switch (sign) {
      case "+":
        return x1 + x2;
      case "-":
        return x1 - x2;
      case "*":
        return x1 * x2;
      case "/":
        return x2 == 0 ? 0 : x1 ~/ x2; // Guard against divide by zero
      default:
        throw ArgumentError("Unsupported operator: $sign");
    }
  }

  /// Returns true if [sign] is a valid operator.
  static bool isOperator(String sign) => ["+", "-", "*", "/"].contains(sign);

  /// Returns operator precedence. Higher means stronger binding.
  static int getPrecedence(String sign) {
    switch (sign) {
      case "+":
      case "-":
        return 1;
      case "*":
        return 2;
      case "/":
        return 3;
      default:
        throw ArgumentError("Invalid operator: $sign");
    }
  }

  /// Generates a random integer between [min] and [max] (exclusive).
  static int generateRandomAnswer(int min, int max) =>
      min + _random.nextInt(max - min);

  /// Returns a random arithmetic operator.
  static String generateRandomSign() {
    const ops = ['/', '*', '-', '+'];
    return ops[_random.nextInt(ops.length)];
  }

  /// Generates [count] random operators.
  static List<String> generateRandomSigns(int count) =>
      List.generate(count, (_) => generateRandomSign());

  /// Generates [count] random numbers in string form.
  static List<String> generateRandomNumbers(int min, int max, int count) {
    return List.generate(count, (_) => generateRandomAnswer(min, max).toString());
  }

  /// Expression with addition.
  static Expression getPlusExp(int min, int max) {
    var nums = generateRandomNumbers(min, max, 2);
    return Expression(
      firstOperand: nums[0],
      operator1: "+",
      secondOperand: nums[1],
      answer: int.parse(nums[0]) + int.parse(nums[1]),
    );
  }

  /// Expression with subtraction ensuring non-negative result.
  static Expression getMinusExp(int min, int max) {
    var x1 = generateRandomAnswer(max ~/ 2, max);
    var x2 = generateRandomAnswer(min, max ~/ 2);
    return Expression(
      firstOperand: "$x1",
      operator1: "-",
      secondOperand: "$x2",
      answer: x1 - x2,
    );
  }

  /// Expression with multiplication.
  static Expression getMultiplyExp(int min, int max) {
    var nums = generateRandomNumbers(min, max, 2);
    return Expression(
      firstOperand: nums[0],
      operator1: "*",
      secondOperand: nums[1],
      answer: int.parse(nums[0]) * int.parse(nums[1]),
    );
  }

  /// Expression with division ensuring clean division.
  static Expression? getDivideExp(int min, int max) {
    var pairs = <MapEntry<int, int>>[];

    for (int i = min; i <= max; i++) {
      for (int j = min; j <= max; j++) {
        if (i != 0 && j % i == 0 && j != i) {
          pairs.add(MapEntry(j, i));
        }
      }
    }

    if (pairs.isEmpty) return null;

    var pair = pairs[_random.nextInt(pairs.length)];
    return Expression(
      firstOperand: "${pair.key}",
      operator1: "/",
      secondOperand: "${pair.value}",
      answer: pair.key ~/ pair.value,
    );
  }

  /// Expression generator combining multiple operators.
  static Expression? getMixedExp(int min, int max) {
    var baseExp = _pickExpression(min, max);
    if (baseExp == null) return null;

    var operand = generateRandomAnswer(min, max);
    var sign = generateRandomSign();

    return _combineExpression(baseExp, sign, operand);
  }

  /// Returns list of expressions for Math Pairs game.
  static List<Expression> getMathPair(int level, int count) {
    return List.generate(count, (_) => _pickExpressionForLevel(level)!)
        .whereType<Expression>()
        .toList();
  }

  /// Returns a set of generated expressions for given level and count.
  static List<Expression> generate(int level, int count) {
    return List.generate(count, (_) => _pickExpressionForLevel(level)!)
        .whereType<Expression>()
        .toList();
  }

  // --- Private helpers ---

  static Expression? _pickExpression(int min, int max) {
    switch (generateRandomSign()) {
      case "+":
        return getPlusExp(min, max);
      case "-":
        return getMinusExp(min, max);
      case "*":
        return getMultiplyExp(min, max);
      case "/":
        return getDivideExp(min, max);
      default:
        return null;
    }
  }

  static Expression? _pickExpressionForLevel(int level) {
    int min = level == 1 ? 1 : (5 * level) - 5;
    int max = level == 1 ? 10 : (10 * level);
    return _pickExpression(min, max);
  }

  /// Returns an expression for mental math game based on level.
  static Expression? getMentalExp(int level) {
    return _pickExpressionForLevel(level);
  }

  static Expression? _combineExpression(
      Expression base, String sign, int operand) {
    switch (sign) {
      case "+":
        return base.copyWith(
          operator2: "+",
          thirdOperand: "$operand",
          answer: base.answer + operand,
        );
      case "-":
        if (base.answer - operand < 0) return null;
        return base.copyWith(
          operator2: "-",
          thirdOperand: "$operand",
          answer: base.answer - operand,
        );
      case "*":
        return base.copyWith(
          operator2: "*",
          thirdOperand: "$operand",
          answer: base.answer * operand,
        );
      case "/":
        if (operand == 0 || base.answer % operand != 0) return null;
        return base.copyWith(
          operator2: "/",
          thirdOperand: "$operand",
          answer: base.answer ~/ operand,
        );
      default:
        return null;
    }
  }
}

/// Represents a mathematical expression with up to two operators.
class Expression {
  final String firstOperand;
  final String operator1;
  final String secondOperand;
  final String? operator2;
  final String? thirdOperand;
  final int answer;

  Expression({
    required this.firstOperand,
    required this.operator1,
    required this.secondOperand,
    required this.answer,
    this.operator2,
    this.thirdOperand,
  });

  Expression copyWith({
    String? firstOperand,
    String? operator1,
    String? secondOperand,
    String? operator2,
    String? thirdOperand,
    int? answer,
  }) {
    return Expression(
      firstOperand: firstOperand ?? this.firstOperand,
      operator1: operator1 ?? this.operator1,
      secondOperand: secondOperand ?? this.secondOperand,
      operator2: operator2 ?? this.operator2,
      thirdOperand: thirdOperand ?? this.thirdOperand,
      answer: answer ?? this.answer,
    );
  }

  @override
  String toString() =>
      "$firstOperand $operator1 $secondOperand ${operator2 ?? ""} ${thirdOperand ?? ""} = $answer";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Expression &&
              firstOperand == other.firstOperand &&
              operator1 == other.operator1 &&
              secondOperand == other.secondOperand &&
              operator2 == other.operator2 &&
              thirdOperand == other.thirdOperand &&
              answer == other.answer;

  @override
  int get hashCode =>
      Object.hash(firstOperand, operator1, secondOperand, operator2, thirdOperand, answer);
}