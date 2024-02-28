import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task_data.g.dart';

@HiveType(typeId: 3)
class TaskData {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final DateTime startTime;
  @HiveField(2)
  final DateTime endTime;
  @HiveField(3)
  late final int colorValue;


  TaskData(
      {required this.taskName,
      required this.startTime,
      required this.endTime,
         required this.colorValue,
       });

  Color get color => Color(colorValue);

  // Метод для преобразования Color в int
  set color(Color color) => colorValue = color.value;
}





