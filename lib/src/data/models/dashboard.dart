import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

class Dashboard {
  final String title;
  final String subtitle;
  final String folder;
  final String outlineIcon;
  final String icon;
  final PuzzleType puzzleType;
  final double opacity;
  final Tuple2<Color, Color> colorTuple;
  Color fillIconColor;
  Color outlineIconColor;
  Color bgColor;
  Color gridColor;
  Color backgroundColor;
  Color primaryColor;
  int position;

  Dashboard({
    required this.puzzleType,
    required this.colorTuple,
    required this.opacity,
    required this.outlineIcon,
    required this.icon,
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
}
