import 'dart:ui';

import 'package:tuple/tuple.dart';

class GameInfoDialog {
  final String title;
  final String image;
  final String dec;
  final double correctAnswerScore;
  final double wrongAnswerScore;
  final Tuple2<Color,Color> colorTuple;

  GameInfoDialog({
    required this.title,
    required this.image,
    required this.dec,
    required this.correctAnswerScore,
    required this.wrongAnswerScore,
    required this.colorTuple,
  });
}
