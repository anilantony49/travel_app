// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DestinationModelsAdapter extends TypeAdapter<DestinationModels> {
  @override
  final int typeId = 11;

  @override
  DestinationModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DestinationModels(
      capital: fields[2] as String,
      id: fields[0] as String,
      countryName: fields[1] as String,
      countryImage: fields[3] as String,
      knownFor: (fields[5] as List).cast<String>(),
      images: (fields[6] as List).cast<String>(),
      majorCities: (fields[7] as List).cast<String>(),
      language: fields[8] as String,
      currency: fields[9] as String,
      digitialCode: fields[10] as String,
      weather: fields[11] as String,
      details: fields[4] as String,
      categories: fields[12] as String,
      rating: fields[13] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DestinationModels obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.capital)
      ..writeByte(3)
      ..write(obj.countryImage)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.knownFor)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.majorCities)
      ..writeByte(8)
      ..write(obj.language)
      ..writeByte(9)
      ..write(obj.currency)
      ..writeByte(10)
      ..write(obj.digitialCode)
      ..writeByte(11)
      ..write(obj.weather)
      ..writeByte(12)
      ..write(obj.categories)
      ..writeByte(13)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestinationModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
