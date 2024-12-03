/// Model class representing a matching pairs math game.
/// Contains a list of pairs and tracks available items for matching.
class MathPairs {
  /// List of all pairs in the game
  List<Pair> list;

  /// Number of items still available for matching
  int availableItem;

  /// Creates a new MathPairs instance.
  ///
  /// Parameters:
  /// - [list]: List of pairs to match
  /// - [availableItem]: Number of available items
  MathPairs(this.list, this.availableItem);

  @override
  String toString() {
    return 'MathPairs{list: $list}';
  }
}

/// Model class representing a single pair item in the matching game.
/// Contains information about the item's state and display text.
class Pair {
  /// Unique identifier for the pair
  int uid;

  /// Text to display for this pair item
  String text;

  /// Whether this pair is currently active/selected
  bool isActive;

  /// Whether this pair is visible on the game board
  bool isVisible;

  /// Creates a new Pair instance.
  ///
  /// Parameters:
  /// - [uid]: Unique identifier
  /// - [text]: Display text
  /// - [isActive]: Initial active state
  /// - [isVisible]: Initial visibility state
  Pair(this.uid, this.text, this.isActive, this.isVisible);

  @override
  String toString() {
    return 'Pair{text: $text, uid: $uid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair && runtimeType == other.runtimeType && text == other.text;

  @override
  int get hashCode => text.hashCode;
}
