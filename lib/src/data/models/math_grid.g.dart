// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_grid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MathGridAdapter extends TypeAdapter<MathGrid> {
  @override
  final int typeId = 20;

  @override
  MathGrid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MathGrid(
      listForSquare: (fields[0] as List).cast<MathGridCellModel>(),
      currentAnswer: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MathGrid obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listForSquare)
      ..writeByte(1)
      ..write(obj.currentAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathGridAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MathGridCellModelAdapter extends TypeAdapter<MathGridCellModel> {
  @override
  final int typeId = 21;

  @override
  MathGridCellModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MathGridCellModel(
      index: fields[0] as int,
      value: fields[1] as int,
      isActive: fields[2] as bool,
      isRemoved: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MathGridCellModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.isRemoved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathGridCellModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
