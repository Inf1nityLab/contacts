// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDataAdapter extends TypeAdapter<TaskData> {
  @override
  final int typeId = 3;

  @override
  TaskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskData(
      taskName: fields[0] as String,
      startTimeHour: fields[1] as int,
      endTimeMinute: fields[6] as int,
      colorValue: fields[3] as int,
      date: fields[4] as DateTime,
      endTimeHour: fields[5] as int,
      startTimeMinute: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.startTimeHour)
      ..writeByte(2)
      ..write(obj.startTimeMinute)
      ..writeByte(3)
      ..write(obj.colorValue)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.endTimeHour)
      ..writeByte(6)
      ..write(obj.endTimeMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
