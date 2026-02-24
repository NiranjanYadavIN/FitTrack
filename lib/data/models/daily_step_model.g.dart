// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_step_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyStepModelAdapter extends TypeAdapter<DailyStepModel> {
  @override
  final int typeId = 1;

  @override
  DailyStepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyStepModel(
      date: fields[0] as DateTime,
      steps: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyStepModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyStepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
