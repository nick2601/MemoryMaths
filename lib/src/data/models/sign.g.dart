// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignAdapter extends TypeAdapter<Sign> {
  @override
  final int typeId = 63;

  @override
  Sign read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sign(
      firstDigit: fields[0] as String,
      sign: fields[1] as String,
      secondDigit: fields[2] as String,
      answer: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sign obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstDigit)
      ..writeByte(1)
      ..write(obj.sign)
      ..writeByte(2)
      ..write(obj.secondDigit)
      ..writeByte(3)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
