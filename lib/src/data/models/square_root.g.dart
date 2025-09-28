// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'square_root.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SquareRootAdapter extends TypeAdapter<SquareRoot> {
  @override
  final int typeId = 12;

  @override
  SquareRoot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SquareRoot(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SquareRoot obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.firstAns)
      ..writeByte(2)
      ..write(obj.secondAns)
      ..writeByte(3)
      ..write(obj.thirdAns)
      ..writeByte(4)
      ..write(obj.fourthAns)
      ..writeByte(5)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SquareRootAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
