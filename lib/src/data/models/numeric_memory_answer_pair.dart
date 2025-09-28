import 'package:hive/hive.dart';

part 'numeric_memory_answer_pair.g.dart';

/// Model class representing a single answer option in a numeric memory game.
/// Contains the answer text and whether it has been checked by the player.
@HiveType(typeId: 42)
class NumericMemoryAnswerPair {
  /// The answer text or value
  @HiveField(0)
  final String key;

  /// Whether this answer has been checked/selected by the player
  @HiveField(1)
  final bool isCheck;

  const NumericMemoryAnswerPair({
    required this.key,
    this.isCheck = false,
  });

  /// Creates a copy with updated values
  NumericMemoryAnswerPair copyWith({
    String? key,
    bool? isCheck,
  }) {
    return NumericMemoryAnswerPair(
      key: key ?? this.key,
      isCheck: isCheck ?? this.isCheck,
    );
  }

  @override
  String toString() => 'NumericMemoryAnswerPair(key: $key, isCheck: $isCheck)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NumericMemoryAnswerPair &&
              runtimeType == other.runtimeType &&
              key == other.key &&
              isCheck == other.isCheck;

  @override
  int get hashCode => key.hashCode ^ isCheck.hashCode;
}