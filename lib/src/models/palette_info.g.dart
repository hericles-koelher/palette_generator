// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palette_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaletteInfoAdapter extends TypeAdapter<PaletteInfo> {
  @override
  final int typeId = 0;

  @override
  PaletteInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaletteInfo(
      name: fields[0] as String,
      id: fields[1] as String,
      colors: (fields[2] as List).cast<int>(),
      creationDate: fields[3] as DateTime,
      isFavorite: fields[5] as bool,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaletteInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.colors)
      ..writeByte(3)
      ..write(obj.creationDate)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaletteInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
