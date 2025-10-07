import 'package:flutter/cupertino.dart';

class GradientModel{
  Color? primaryColor;
  Color? cellColor;
  Color? bgColor;
  Color? gridColor;
  Color? backgroundColor;
  String? folderName;
  List<Color>? colors;

  GradientModel({
    this.primaryColor,
    this.cellColor,
    this.bgColor,
    this.gridColor,
    this.backgroundColor,
    this.folderName,
    this.colors,
  });
}