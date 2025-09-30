// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradientModelAdapter extends TypeAdapter<GradientModel> {
  @override
  final int typeId = 40;

  @override
  GradientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradientModel(
      primaryColor: fields[0] as Color?,
      cellColor: fields[1] as Color?,
      bgColor: fields[2] as Color?,
      gridColor: fields[3] as Color?,
      backgroundColor: fields[4] as Color?,
      folderName: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GradientModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.primaryColor)
      ..writeByte(1)
      ..write(obj.cellColor)
      ..writeByte(2)
      ..write(obj.bgColor)
      ..writeByte(3)
      ..write(obj.gridColor)
      ..writeByte(4)
      ..write(obj.backgroundColor)
      ..writeByte(5)
      ..write(obj.folderName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
