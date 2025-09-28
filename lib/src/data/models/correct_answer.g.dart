// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correct_answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CorrectAnswerAdapter extends TypeAdapter<CorrectAnswer> {
  @override
  final int typeId = 4;

  @override
  CorrectAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CorrectAnswer(
      question: fields[0] as Question,
      firstAns: fields[1] as String,
      secondAns: fields[2] as String,
      thirdAns: fields[3] as String,
      fourthAns: fields[4] as String,
      answer: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CorrectAnswer obj) {
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
      other is CorrectAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 5;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      firstOperand: fields[0] as Operand,
      firstOperator: fields[1] as String,
      secondOperand: fields[2] as Operand,
      secondOperator: fields[3] as String?,
      thirdOperand: fields[4] as Operand?,
      answer: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.firstOperand)
      ..writeByte(1)
      ..write(obj.firstOperator)
      ..writeByte(2)
      ..write(obj.secondOperand)
      ..writeByte(3)
      ..write(obj.secondOperator)
      ..writeByte(4)
      ..write(obj.thirdOperand)
      ..writeByte(5)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OperandAdapter extends TypeAdapter<Operand> {
  @override
  final int typeId = 6;

  @override
  Operand read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operand(
      value: fields[0] as String,
      isQuestionMark: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Operand obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.isQuestionMark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
