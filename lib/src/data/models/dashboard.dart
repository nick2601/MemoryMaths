import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:tuple/tuple.dart';
import 'package:mathsgames/src/core/app_constant.dart';

part 'dashboard.g.dart';

/// Model representing a dashboard puzzle entry.
@HiveType(typeId: 64) // ⚠️ pick a unique typeId
class Dashboard {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String subtitle;

  @HiveField(2)
  final String folder;

  @HiveField(3)
  final String outlineIcon;

  @HiveField(4)
  final PuzzleType puzzleType;

  @HiveField(5)
  final double opacity;

  @HiveField(6)
  final Tuple2<Color, Color> colorTuple;

  @HiveField(7)
  final Color fillIconColor;

  @HiveField(8)
  final Color outlineIconColor;

  @HiveField(9)
  final Color bgColor;

  @HiveField(10)
  final Color gridColor;

  @HiveField(11)
  final Color backgroundColor;

  @HiveField(12)
  final Color primaryColor;

  @HiveField(13)
  final int position;

  const Dashboard({
    required this.puzzleType,
    required this.colorTuple,
    required this.opacity,
    required this.outlineIcon,
    required this.subtitle,
    required this.bgColor,
    required this.gridColor,
    required this.position,
    required this.title,
    required this.folder,
    required this.fillIconColor,
    required this.primaryColor,
    required this.outlineIconColor,
    required this.backgroundColor,
  });

  Dashboard copyWith({
    String? title,
    String? subtitle,
    String? folder,
    String? outlineIcon,
    PuzzleType? puzzleType,
    double? opacity,
    Tuple2<Color, Color>? colorTuple,
    Color? fillIconColor,
    Color? outlineIconColor,
    Color? bgColor,
    Color? gridColor,
    Color? backgroundColor,
    Color? primaryColor,
    int? position,
  }) {
    return Dashboard(
      puzzleType: puzzleType ?? this.puzzleType,
      colorTuple: colorTuple ?? this.colorTuple,
      opacity: opacity ?? this.opacity,
      outlineIcon: outlineIcon ?? this.outlineIcon,
      subtitle: subtitle ?? this.subtitle,
      bgColor: bgColor ?? this.bgColor,
      gridColor: gridColor ?? this.gridColor,
      position: position ?? this.position,
      title: title ?? this.title,
      folder: folder ?? this.folder,
      fillIconColor: fillIconColor ?? this.fillIconColor,
      primaryColor: primaryColor ?? this.primaryColor,
      outlineIconColor: outlineIconColor ?? this.outlineIconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  /// JSON conversion for API or config sync
  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    puzzleType: PuzzleType.values.firstWhere(
          (e) => e.toString() == json['puzzleType'],
      orElse: () => PuzzleType.values.first,
    ),
    colorTuple: Tuple2(
      Color(json['colorTuple'][0]),
      Color(json['colorTuple'][1]),
    ),
    opacity: (json['opacity'] as num).toDouble(),
    outlineIcon: json['outlineIcon'],
    subtitle: json['subtitle'],
    bgColor: Color(json['bgColor']),
    gridColor: Color(json['gridColor']),
    position: json['position'],
    title: json['title'],
    folder: json['folder'],
    fillIconColor: Color(json['fillIconColor']),
    primaryColor: Color(json['primaryColor']),
    outlineIconColor: Color(json['outlineIconColor']),
    backgroundColor: Color(json['backgroundColor']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'folder': folder,
    'outlineIcon': outlineIcon,
    'puzzleType': puzzleType.toString(),
    'opacity': opacity,
    'colorTuple': [colorTuple.item1.value, colorTuple.item2.value],
    'fillIconColor': fillIconColor.value,
    'outlineIconColor': outlineIconColor.value,
    'bgColor': bgColor.value,
    'gridColor': gridColor.value,
    'backgroundColor': backgroundColor.value,
    'primaryColor': primaryColor.value,
    'position': position,
  };

  @override
  String toString() =>
      'Dashboard(title: $title, subtitle: $subtitle, position: $position, puzzleType: $puzzleType)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Dashboard &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              subtitle == other.subtitle &&
              position == other.position &&
              puzzleType == other.puzzleType;

  @override
  int get hashCode =>
      Object.hash(title, subtitle, position, puzzleType);
}