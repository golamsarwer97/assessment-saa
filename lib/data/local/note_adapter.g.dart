// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHiveAdapter extends TypeAdapter<NoteHive> {
  @override
  final int typeId = 0;

  @override
  NoteHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteHive(
      id: fields[0] as String?,
      title: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
      color: fields[5] as String,
      isSynced: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NoteHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
