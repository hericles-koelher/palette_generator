// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_by_palette.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortByPaletteAdapter extends TypeAdapter<SortByPalette> {
  @override
  final int typeId = 1;

  @override
  SortByPalette read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortByPalette.name;
      case 1:
        return SortByPalette.creationDate;
      case 2:
        return SortByPalette.lastUpdate;
      default:
        return SortByPalette.name;
    }
  }

  @override
  void write(BinaryWriter writer, SortByPalette obj) {
    switch (obj) {
      case SortByPalette.name:
        writer.writeByte(0);
        break;
      case SortByPalette.creationDate:
        writer.writeByte(1);
        break;
      case SortByPalette.lastUpdate:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortByPaletteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
