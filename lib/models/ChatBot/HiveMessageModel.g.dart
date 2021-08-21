// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveMessageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelHiveAdaptor extends TypeAdapter<HiveMessages> {
  @override
  final int typeId = 1;

  @override
  HiveMessages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMessages(
      message: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMessages obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelHiveAdaptor &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
