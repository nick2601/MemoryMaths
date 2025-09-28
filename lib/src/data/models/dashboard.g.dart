// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardAdapter extends TypeAdapter<Dashboard> {
  @override
  final int typeId = 64;

  @override
  Dashboard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dashboard(
      puzzleType: fields[4] as PuzzleType,
      colorTuple: fields[6] as Tuple2<Color, Color>,
      opacity: fields[5] as double,
      outlineIcon: fields[3] as String,
      subtitle: fields[1] as String,
      bgColor: fields[9] as Color,
      gridColor: fields[10] as Color,
      position: fields[13] as int,
      title: fields[0] as String,
      folder: fields[2] as String,
      fillIconColor: fields[7] as Color,
      primaryColor: fields[12] as Color,
      outlineIconColor: fields[8] as Color,
      backgroundColor: fields[11] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, Dashboard obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.folder)
      ..writeByte(3)
      ..write(obj.outlineIcon)
      ..writeByte(4)
      ..write(obj.puzzleType)
      ..writeByte(5)
      ..write(obj.opacity)
      ..writeByte(6)
      ..write(obj.colorTuple)
      ..writeByte(7)
      ..write(obj.fillIconColor)
      ..writeByte(8)
      ..write(obj.outlineIconColor)
      ..writeByte(9)
      ..write(obj.bgColor)
      ..writeByte(10)
      ..write(obj.gridColor)
      ..writeByte(11)
      ..write(obj.backgroundColor)
      ..writeByte(12)
      ..write(obj.primaryColor)
      ..writeByte(13)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
