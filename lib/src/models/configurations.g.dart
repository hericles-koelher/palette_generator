// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigurationsAdapter extends TypeAdapter<Configurations> {
  @override
  final int typeId = 2;

  @override
  Configurations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Configurations(
      minColors: fields[0] == null ? 4 : fields[0] as int,
      maxColors: fields[1] == null ? 32 : fields[1] as int,
      sortByPalette: fields[2] as SortByPalette,
    );
  }

  @override
  void write(BinaryWriter writer, Configurations obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.minColors)
      ..writeByte(1)
      ..write(obj.maxColors)
      ..writeByte(2)
      ..write(obj.sortByPalette);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigurationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
