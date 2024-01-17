// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesModelsAdapter extends TypeAdapter<FavoritesModels> {
  @override
  final int typeId = 9;

  @override
  FavoritesModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritesModels(
      id: fields[0] as String,
      image: fields[2] as String,
      place: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritesModels obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.place);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
