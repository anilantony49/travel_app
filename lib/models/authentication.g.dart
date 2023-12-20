// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticationModelsAdapter extends TypeAdapter<AuthenticationModels> {
  @override
  final int typeId = 1;

  @override
  AuthenticationModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticationModels(
      id: fields[0] as String,
      name: fields[1] as String,
      password: fields[3] as String,
      username: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticationModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
