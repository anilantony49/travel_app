// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentModelsAdapter extends TypeAdapter<CommentModels> {
  @override
  final int typeId = 12;

  @override
  CommentModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentModels(
      commentindex: fields[1] as String,
      userid: fields[0] as int,
      comment: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CommentModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.commentindex)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
