import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_data.g.dart';

@HiveType(typeId: 3)
class TaskData {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final int startTimeHour;
  @HiveField(2)
  final int startTimeMinute;
  @HiveField(3)
  final int colorValue;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final int endTimeHour;
  @HiveField(6)
  final int endTimeMinute;

  TaskData(
      {required this.taskName,
      required this.startTimeHour,
      required this.endTimeMinute,
      required this.colorValue,
      required this.date,
      required this.endTimeHour,
      required this.startTimeMinute});
}


