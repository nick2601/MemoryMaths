import 'dart:ui';
import 'package:tuple/tuple.dart';

/// Model class representing the information dialog shown for each game.
/// Contains all the necessary information to display game instructions and scoring rules.
class GameInfoDialog {
  /// The title of the game to be displayed
  final String title;

  /// Path to the game's instruction image or animation
  final String image;

  /// Description of how to play the game
  final String dec;

  /// Points awarded for correct answers
  final double correctAnswerScore;

  /// Points deducted for wrong answers
  final double wrongAnswerScore;

  /// Color pair for theming the dialog
  /// First color is primary, second is background
  final Tuple2<Color, Color> colorTuple;

  /// Creates a new GameInfoDialog instance.
  ///
  /// Parameters:
  /// - [title]: Game title
  /// - [image]: Path to instruction image/animation
  /// - [dec]: Game description and instructions
  /// - [correctAnswerScore]: Points for correct answers
  /// - [wrongAnswerScore]: Points deducted for wrong answers
  /// - [colorTuple]: Theme colors (primary, background)
  GameInfoDialog({
    required this.title,
    required this.image,
    required this.dec,
    required this.correctAnswerScore,
    required this.wrongAnswerScore,
    required this.colorTuple,
  });
}
