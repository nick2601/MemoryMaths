// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mental_arithmetic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MentalArithmeticAdapter extends TypeAdapter<MentalArithmetic> {
  @override
  final int typeId = 32;

  @override
  MentalArithmetic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MentalArithmetic(
      questionList: (fields[0] as List).cast<String>(),
      answer: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MentalArithmetic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.questionList)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalArithmeticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
