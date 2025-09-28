// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numeric_memory_pair.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumericMemoryPairAdapter extends TypeAdapter<NumericMemoryPair> {
  @override
  final int typeId = 43;

  @override
  NumericMemoryPair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumericMemoryPair(
      question: fields[0] as int,
      answer: fields[1] as String,
      options: (fields[2] as List).cast<NumericMemoryAnswerPair>(),
    );
  }

  @override
  void write(BinaryWriter writer, NumericMemoryPair obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumericMemoryPairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
