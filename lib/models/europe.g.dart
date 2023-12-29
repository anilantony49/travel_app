// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'europe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EuropeDestinationModelsAdapter
    extends TypeAdapter<EuropeDestinationModels> {
  @override
  final int typeId = 3;

  @override
  EuropeDestinationModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EuropeDestinationModels(
      id: fields[0] as String,
      countryName: fields[1] as String,
      countryImage: fields[2] as String,
      description: fields[3] as String,
      capital: fields[4] as String,
      images: (fields[5] as List).cast<String>(),
      language: fields[7] as String,
      currency: fields[8] as String,
      digitialCode: fields[9] as String,
      weather: fields[14] as String,
      police: fields[15] as int,
      ambulance: fields[16] as int,
      fire: fields[17] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EuropeDestinationModels obj) {
    writer
      ..writeByte(13)
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
      other is EuropeDestinationModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
