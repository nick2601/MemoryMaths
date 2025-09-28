// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_workout_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelWorkoutDataAdapter extends TypeAdapter<ModelWorkoutData> {
  @override
  final int typeId = 33;

  @override
  ModelWorkoutData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelWorkoutData(
      question: fields[0] as String,
      answer: fields[1] as String,
      optA: fields[2] as String,
      optB: fields[3] as String,
      optC: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelWorkoutData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.optA)
      ..writeByte(3)
      ..write(obj.optB)
      ..writeByte(4)
      ..write(obj.optC);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelWorkoutDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
