// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_pyramid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumberPyramidAdapter extends TypeAdapter<NumberPyramid> {
  @override
  final int typeId = 40;

  @override
  NumberPyramid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumberPyramid(
      id: fields[0] as int,
      list: (fields[1] as List).cast<NumPyramidCellModel>(),
      remainingCell: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NumberPyramid obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.list)
      ..writeByte(2)
      ..write(obj.remainingCell);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberPyramidAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NumPyramidCellModelAdapter extends TypeAdapter<NumPyramidCellModel> {
  @override
  final int typeId = 41;

  @override
  NumPyramidCellModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumPyramidCellModel(
      id: fields[0] as int,
      text: fields[1] as String,
      numberOnCell: fields[2] as int,
      isActive: fields[3] as bool,
      isCorrect: fields[4] as bool,
      isHidden: fields[5] as bool,
      isHint: fields[6] as bool,
      isDone: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NumPyramidCellModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.numberOnCell)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.isCorrect)
      ..writeByte(5)
      ..write(obj.isHidden)
      ..writeByte(6)
      ..write(obj.isHint)
      ..writeByte(7)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumPyramidCellModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
