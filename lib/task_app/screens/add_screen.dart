import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app_hive/locator.dart';
import 'package:to_do_app_hive/task_app/model/task_data.dart';
import 'package:to_do_app_hive/task_app/service/task_service.dart';
import 'package:to_do_app_hive/task_app/widget/time_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = TextEditingController();
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 50);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {},
          icon: Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.only(left: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.indigo,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 150,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Add Task',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child:Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Calendar
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'Task Name',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Task name'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: startTime);

                              if (newTime == null) return;

                              setState(() => startTime = newTime);
                            },
                            child: Text('${startTime.hour}:${startTime.minute}')),
                        ElevatedButton(
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: endTime);

                              if (newTime == null) return;

                              setState(() => endTime = newTime);
                            },
                            child: Text('${endTime.hour}:${endTime.minute}')),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            locator<TaskService>().addTodo(TaskData(
                              taskName: nameController.text,
                              startTime: DateTime(startTime.hour, startTime.minute),
                              endTime: DateTime(endTime.hour, endTime.minute),
                              colorValue: 0xFFdbe4f3,
                            ));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add Data'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}

// enum Color {red, green, indigo, black}
//
// class Button extends StatefulWidget {
//   const Button({super.key});
//
//   @override
//   State<Button> createState() => _ButtonState();
// }
//
// class _ButtonState extends State<Button> {
//
//   @override
//   Widget build(BuildContext context) {
//     return  SegmentedButton(segments: [
//       ButtonSegment(value: Colors.green),
//       ButtonSegment(value: Colors.indigo),
//       ButtonSegment(value: Colors.red),
//       ButtonSegment(value: Colors.black87),
//     ], selected: Set<Color>);
//   }
// }
