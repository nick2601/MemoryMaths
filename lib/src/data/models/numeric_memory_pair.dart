import 'package:hive/hive.dart';
import 'numeric_memory_answer_pair.dart';

part 'numeric_memory_pair.g.dart';

/// Model class representing a numeric memory question and its possible answers.
/// Used in memory-based math games where players need to recall numbers.
@HiveType(typeId: 43)
class NumericMemoryPair {
  /// The numeric question or value to remember
  @HiveField(0)
  final int question;

  /// The correct answer to the memory question
  @HiveField(1)
  final String answer;

  /// List of possible answer pairs that players can choose from
  @HiveField(2)
  final List<NumericMemoryAnswerPair> options;

  const NumericMemoryPair({
    required this.question,
    required this.answer,
    required this.options,
  });

  /// Creates a copy with updated values (useful for Riverpod state updates)
  NumericMemoryPair copyWith({
    int? question,
    String? answer,
    List<NumericMemoryAnswerPair>? options,
  }) {
    return NumericMemoryPair(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      options: options ?? this.options,
    );
  }

  @override
  String toString() =>
      'NumericMemoryPair(question: $question, answer: $answer, options: $options)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NumericMemoryPair &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer &&
              options == other.options;

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ options.hashCode;
}