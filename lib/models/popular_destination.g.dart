// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_destination.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopularDestinationModelsAdapter
    extends TypeAdapter<PopularDestinationModels> {
  @override
  final int typeId = 2;

  @override
  PopularDestinationModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularDestinationModels(
      id: fields[0] as String,
      countryName: fields[1] as String,
      countryImage: fields[2] as String,
      description: fields[3] as String,
      images: (fields[5] as List).cast<String>(),
      language: fields[7] as String,
      currency: fields[8] as String,
      digitialCode: fields[9] as String,
      weather: fields[14] as String,
      police: fields[15] as String,
      ambulance: fields[16] as String,
      fire: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PopularDestinationModels obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.countryImage)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.currency)
      ..writeByte(9)
      ..write(obj.digitialCode)
      ..writeByte(14)
      ..write(obj.weather)
      ..writeByte(15)
      ..write(obj.police)
      ..writeByte(16)
      ..write(obj.ambulance)
      ..writeByte(17)
      ..write(obj.fire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularDestinationModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
