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
        return SortByPalette.name_ascending;
      case 1:
        return SortByPalette.name_descending;
      case 2:
        return SortByPalette.creation_ascending;
      case 3:
        return SortByPalette.creation_descending;
      case 4:
        return SortByPalette.last_update;
      default:
        return SortByPalette.name_ascending;
    }
  }

  @override
  void write(BinaryWriter writer, SortByPalette obj) {
    switch (obj) {
      case SortByPalette.name_ascending:
        writer.writeByte(0);
        break;
      case SortByPalette.name_descending:
        writer.writeByte(1);
        break;
      case SortByPalette.creation_ascending:
        writer.writeByte(2);
        break;
      case SortByPalette.creation_descending:
        writer.writeByte(3);
        break;
      case SortByPalette.last_update:
        writer.writeByte(4);
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
