// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GratitudeAdapter extends TypeAdapter<Gratitude> {
  @override
  final int typeId = 0;

  @override
  Gratitude read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gratitude()
      ..journalLog = fields[0] as String
      ..date = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Gratitude obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.journalLog)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GratitudeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
