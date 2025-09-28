import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'math_pairs.g.dart';

/// Model class representing a matching pairs math game.
/// Contains a list of pairs and tracks available items for matching.
@HiveType(typeId: 30)
class MathPairs {
  /// List of all pairs in the game
  @HiveField(0)
  final List<Pair> list;

  /// Number of items still available for matching
  int get availableItem => list.where((p) => p.isVisible).length;

  /// Creates a new MathPairs instance.
  MathPairs({required this.list});

  MathPairs copyWith({List<Pair>? list}) {
    return MathPairs(list: list ?? this.list);
  }

  @override
  String toString() => 'MathPairs(availableItem: $availableItem, list: $list)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MathPairs &&
              const DeepCollectionEquality().equals(list, other.list);

  @override
  int get hashCode => const DeepCollectionEquality().hash(list);
}

/// Model class representing a single pair item in the matching game.
/// Contains information about the item's state and display text.
@HiveType(typeId: 31)
class Pair {
  /// Unique identifier for the pair
  @HiveField(0)
  final int uid;

  /// Text to display for this pair item
  @HiveField(1)
  final String text;

  /// Whether this pair is currently active/selected
  @HiveField(2)
  final bool isActive;

  /// Whether this pair is visible on the game board
  @HiveField(3)
  final bool isVisible;

  Pair({
    required this.uid,
    required this.text,
    this.isActive = false,
    this.isVisible = true,
  });

  Pair copyWith({
    int? uid,
    String? text,
    bool? isActive,
    bool? isVisible,
  }) {
    return Pair(
      uid: uid ?? this.uid,
      text: text ?? this.text,
      isActive: isActive ?? this.isActive,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  String toString() =>
      'Pair(uid: $uid, text: $text, active: $isActive, visible: $isVisible)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pair &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              text == other.text;

  @override
  int get hashCode => uid.hashCode ^ text.hashCode;
}