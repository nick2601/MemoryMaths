// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_missing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FindMissingQuizModelAdapter extends TypeAdapter<FindMissingQuizModel> {
  @override
  final int typeId = 4;

  @override
  FindMissingQuizModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FindMissingQuizModel(
      sign: fields[0] as String?,
      rem: fields[1] as String?,
      id: fields[2] as int?,
      firstDigit: fields[3] as String?,
      secondDigit: fields[4] as String?,
      question: fields[5] as String?,
      answer: fields[6] as String?,
      op_1: fields[7] as String?,
      op_2: fields[8] as String?,
      op_3: fields[9] as String?,
      optionList: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FindMissingQuizModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.sign)
      ..writeByte(1)
      ..write(obj.rem)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.firstDigit)
      ..writeByte(4)
      ..write(obj.secondDigit)
      ..writeByte(5)
      ..write(obj.question)
      ..writeByte(6)
      ..write(obj.answer)
      ..writeByte(7)
      ..write(obj.op_1)
      ..writeByte(8)
      ..write(obj.op_2)
      ..writeByte(9)
      ..write(obj.op_3)
      ..writeByte(10)
      ..write(obj.optionList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FindMissingQuizModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
