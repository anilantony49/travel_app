// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'africa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AfricaDestinationModelsAdapter
    extends TypeAdapter<AfricaDestinationModels> {
  @override
  final int typeId = 4;

  @override
  AfricaDestinationModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AfricaDestinationModels(
      id: fields[0] as String,
      countryName: fields[1] as String,
      countryImage: fields[2] as String,
      description: fields[3] as String,
      capital: fields[4] as String,
      knownFor: (fields[5] as List).cast<String>(),
      images: (fields[6] as List).cast<String>(),
      majorCities: (fields[7] as List).cast<String>(),
      language: fields[8] as String,
      currency: fields[9] as String,
      digitialCode: fields[10] as String,
      weather: fields[14] as String,
      police: fields[15] as int,
      ambulance: fields[16] as int,
      fire: fields[17] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AfricaDestinationModels obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.countryImage)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.capital)
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
      other is AfricaDestinationModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
