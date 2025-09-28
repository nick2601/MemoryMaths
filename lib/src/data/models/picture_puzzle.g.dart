// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_puzzle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PicturePuzzleAdapter extends TypeAdapter<PicturePuzzle> {
  @override
  final int typeId = 52;

  @override
  PicturePuzzle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PicturePuzzle(
      list: (fields[0] as List).cast<PicturePuzzleShapeList>(),
      answer: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PicturePuzzle obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PicturePuzzleShapeListAdapter
    extends TypeAdapter<PicturePuzzleShapeList> {
  @override
  final int typeId = 53;

  @override
  PicturePuzzleShapeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PicturePuzzleShapeList(
      (fields[0] as List).cast<PicturePuzzleShape>(),
    );
  }

  @override
  void write(BinaryWriter writer, PicturePuzzleShapeList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.shapeList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleShapeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PicturePuzzleShapeAdapter extends TypeAdapter<PicturePuzzleShape> {
  @override
  final int typeId = 54;

  @override
  PicturePuzzleShape read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PicturePuzzleShape(
      shapeType: fields[0] as PicturePuzzleShapeType?,
      text: fields[1] as String,
      type: fields[2] as PicturePuzzleQuestionItemType,
    );
  }

  @override
  void write(BinaryWriter writer, PicturePuzzleShape obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.shapeType)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleShapeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PicturePuzzleDataAdapter extends TypeAdapter<PicturePuzzleData> {
  @override
  final int typeId = 55;

  @override
  PicturePuzzleData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PicturePuzzleData(
      fields[0] as PicturePuzzleShapeType,
      fields[1] as String,
      fields[2] as PicturePuzzleShapeType,
      fields[3] as String,
      fields[4] as PicturePuzzleShapeType,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PicturePuzzleData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.shapeType1)
      ..writeByte(1)
      ..write(obj.sign1)
      ..writeByte(2)
      ..write(obj.shapeType2)
      ..writeByte(3)
      ..write(obj.sign2)
      ..writeByte(4)
      ..write(obj.shapeType3)
      ..writeByte(5)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PicturePuzzleQuestionItemTypeAdapter
    extends TypeAdapter<PicturePuzzleQuestionItemType> {
  @override
  final int typeId = 50;

  @override
  PicturePuzzleQuestionItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PicturePuzzleQuestionItemType.shape;
      case 1:
        return PicturePuzzleQuestionItemType.sign;
      case 2:
        return PicturePuzzleQuestionItemType.hint;
      case 3:
        return PicturePuzzleQuestionItemType.answer;
      default:
        return PicturePuzzleQuestionItemType.shape;
    }
  }

  @override
  void write(BinaryWriter writer, PicturePuzzleQuestionItemType obj) {
    switch (obj) {
      case PicturePuzzleQuestionItemType.shape:
        writer.writeByte(0);
        break;
      case PicturePuzzleQuestionItemType.sign:
        writer.writeByte(1);
        break;
      case PicturePuzzleQuestionItemType.hint:
        writer.writeByte(2);
        break;
      case PicturePuzzleQuestionItemType.answer:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleQuestionItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PicturePuzzleShapeTypeAdapter
    extends TypeAdapter<PicturePuzzleShapeType> {
  @override
  final int typeId = 51;

  @override
  PicturePuzzleShapeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PicturePuzzleShapeType.circle;
      case 1:
        return PicturePuzzleShapeType.square;
      case 2:
        return PicturePuzzleShapeType.triangle;
      default:
        return PicturePuzzleShapeType.circle;
    }
  }

  @override
  void write(BinaryWriter writer, PicturePuzzleShapeType obj) {
    switch (obj) {
      case PicturePuzzleShapeType.circle:
        writer.writeByte(0);
        break;
      case PicturePuzzleShapeType.square:
        writer.writeByte(1);
        break;
      case PicturePuzzleShapeType.triangle:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicturePuzzleShapeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
