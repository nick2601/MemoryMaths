import 'numeric_memory_answer_pair.dart';

/// Model class representing a numeric memory question and its possible answers.
/// Used in memory-based math games where players need to recall numbers.
class NumericMemoryPair {
  /// The correct answer to the memory question
  String? answer;

  /// The numeric question or value to remember
  int? question;

  /// List of possible answer pairs that players can choose from
  List<NumericMemoryAnswerPair> list = [];
}
