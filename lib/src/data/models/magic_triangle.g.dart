// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magic_triangle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MagicTriangleAdapter extends TypeAdapter<MagicTriangle> {
  @override
  final int typeId = 10;

  @override
  MagicTriangle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MagicTriangle(
      listGrid: (fields[0] as List).cast<MagicTriangleGrid>(),
      listTriangle: (fields[1] as List).cast<MagicTriangleInput>(),
      answer: fields[2] as int,
    )..availableDigit = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, MagicTriangle obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.listGrid)
      ..writeByte(1)
      ..write(obj.listTriangle)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.availableDigit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicTriangleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MagicTriangleGridAdapter extends TypeAdapter<MagicTriangleGrid> {
  @override
  final int typeId = 11;

  @override
  MagicTriangleGrid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MagicTriangleGrid(
      fields[0] as int,
      fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MagicTriangleGrid obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.isVisible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicTriangleGridAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MagicTriangleInputAdapter extends TypeAdapter<MagicTriangleInput> {
  @override
  final int typeId = 12;

  @override
  MagicTriangleInput read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MagicTriangleInput(
      fields[0] as bool,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MagicTriangleInput obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isActive)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicTriangleInputAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
