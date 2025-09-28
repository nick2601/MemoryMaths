// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ComplexModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComplexModelAdapter extends TypeAdapter<ComplexModel> {
  @override
  final int typeId = 31;

  @override
  ComplexModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComplexModel(
      question: fields[0] as String?,
      finalAnswer: fields[1] as String?,
      answer: fields[2] as String?,
      optionList: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ComplexModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.finalAnswer)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.optionList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
