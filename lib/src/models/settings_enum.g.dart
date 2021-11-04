// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortByPaletteAdapter extends TypeAdapter<SortByPalette> {
  @override
  final int typeId = 2;

  @override
  SortByPalette read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortByPalette.name_ascending;
      case 1:
        return SortByPalette.name_descending;
      case 2:
        return SortByPalette.creation_oldest;
      case 3:
        return SortByPalette.creation_newest;
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
      case SortByPalette.creation_oldest:
        writer.writeByte(2);
        break;
      case SortByPalette.creation_newest:
        writer.writeByte(3);
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

class FileTypeAdapter extends TypeAdapter<FileType> {
  @override
  final int typeId = 3;

  @override
  FileType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FileType.gpl;
      case 1:
        return FileType.jasc_pal;
      case 2:
        return FileType.hex;
      default:
        return FileType.gpl;
    }
  }

  @override
  void write(BinaryWriter writer, FileType obj) {
    switch (obj) {
      case FileType.gpl:
        writer.writeByte(0);
        break;
      case FileType.jasc_pal:
        writer.writeByte(1);
        break;
      case FileType.hex:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
