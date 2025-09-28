// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numeric_memory_answer_pair.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumericMemoryAnswerPairAdapter
    extends TypeAdapter<NumericMemoryAnswerPair> {
  @override
  final int typeId = 42;

  @override
  NumericMemoryAnswerPair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumericMemoryAnswerPair(
      key: fields[0] as String,
      isCheck: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NumericMemoryAnswerPair obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.isCheck);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumericMemoryAnswerPairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
