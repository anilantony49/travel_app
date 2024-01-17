// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelsAdapter extends TypeAdapter<CategoryModels> {
  @override
  final int typeId = 13;

  @override
  CategoryModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModels(
      id: fields[0] as String,
      category: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModels obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
