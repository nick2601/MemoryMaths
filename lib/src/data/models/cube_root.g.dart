// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cube_root.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CubeRootAdapter extends TypeAdapter<CubeRoot> {
  @override
  final int typeId = 7;

  @override
  CubeRoot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CubeRoot(
      question: fields[0] as String,
      firstAns: fields[1] as String,
      secondAns: fields[2] as String,
      thirdAns: fields[3] as String,
      fourthAns: fields[4] as String,
      answer: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CubeRoot obj) {
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
      other is CubeRootAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
