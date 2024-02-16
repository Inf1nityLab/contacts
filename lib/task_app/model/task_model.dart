import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 3)
class TaskModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime startTime;
  @HiveField(2)
  final DateTime endTime;
  @HiveField(3)
  final Color color;

  TaskModel(
      {required this.name,
      required this.startTime,
      required this.endTime,
      required this.color});
}


