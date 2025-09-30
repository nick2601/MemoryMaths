import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'gradient_model.g.dart';

@HiveType(typeId: 40)
class GradientModel extends HiveObject {
  @HiveField(0)
  Color? primaryColor;

  @HiveField(1)
  Color? cellColor;

  @HiveField(2)
  Color? bgColor;

  @HiveField(3)
  Color? gridColor;

  @HiveField(4)
  Color? backgroundColor;

  @HiveField(5)
  String? folderName;

  GradientModel({
    this.primaryColor,
    this.cellColor,
    this.bgColor,
    this.gridColor,
    this.backgroundColor,
    this.folderName,
  });
}