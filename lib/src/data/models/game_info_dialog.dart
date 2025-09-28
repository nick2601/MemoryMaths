import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'game_info_dialog.freezed.dart';
part 'game_info_dialog.g.dart';

/// Custom Hive converter for Color (stores ARGB as int)
class ColorConverter {
  static int toJson(Color color) => color.value;
  static Color fromJson(int value) => Color(value);
}

/// Model class representing the information dialog shown for each game.
/// Contains all the necessary information to display game instructions and scoring rules.
@freezed
@HiveType(typeId: 5) // ⚡ Ensure unique typeId
class GameInfoDialog with _$GameInfoDialog {
  /// Creates a new GameInfoDialog instance.
  const factory GameInfoDialog({
    /// The title of the game to be displayed
    @HiveField(0) required String title,

    /// Path to the game's instruction image or animation
    @HiveField(1) required String image,

    /// Description of how to play the game
    @HiveField(2) required String dec,

    /// Points awarded for correct answers
    @HiveField(3) required double correctAnswerScore,

    /// Points deducted for wrong answers
    @HiveField(4) required double wrongAnswerScore,

    /// Primary theme color
    @HiveField(5) @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson) required Color primaryColor,

    /// Background theme color
    @HiveField(6) @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson) required Color backgroundColor,
  }) = _GameInfoDialog;

  /// JSON factory for API / Firebase
  factory GameInfoDialog.fromJson(Map<String, dynamic> json) =>
      _$GameInfoDialogFromJson(json);
}