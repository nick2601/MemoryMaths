// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_pairs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MathPairsAdapter extends TypeAdapter<MathPairs> {
  @override
  final int typeId = 30;

  @override
  MathPairs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MathPairs(
      list: (fields[0] as List).cast<Pair>(),
    );
  }

  @override
  void write(BinaryWriter writer, MathPairs obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathPairsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PairAdapter extends TypeAdapter<Pair> {
  @override
  final int typeId = 31;

  @override
  Pair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pair(
      uid: fields[0] as int,
      text: fields[1] as String,
      isActive: fields[2] as bool,
      isVisible: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pair obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.isVisible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
