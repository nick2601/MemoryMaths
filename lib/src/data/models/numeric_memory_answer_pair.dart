/// Model class representing a single answer option in a numeric memory game.
/// Contains the answer text and whether it has been checked by the player.
class NumericMemoryAnswerPair {
  /// The answer text or value
  String? key;

  /// Whether this answer has been checked/selected by the player
  bool? isCheck;
}
