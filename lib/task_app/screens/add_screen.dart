import 'package:easy_date_timeline/easy_date_timeline.dart';
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
  int selectedColor = 0xFF00FF00;
  List<Color> colors = const [
    Color(0xFF00FF00),
    Color(0xFFFF0000),
    Color(0xFF0000FF),
    Color(0xFFFFFF00)
  ];

  DateTime _selectedDay = DateTime.now();

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
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Calendar
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          setState(() {
                            _selectedDay = selectedDate;
                            print('date changed');
                          });
                        },
                        headerProps: const EasyHeaderProps(
                            showMonthPicker: false,
                            monthPickerType: MonthPickerType.dropDown,
                            dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
                            selectedDateStyle: TextStyle(color: Colors.white)),
                        dayProps: const EasyDayProps(
                          dayStructure: DayStructure.dayStrDayNum,
                          width: 70,
                          height: 80,
                          inactiveDayStyle: DayStyle(
                            dayNumStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            dayStrStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          activeDayStyle: DayStyle(
                            dayNumStyle: TextStyle(
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            dayStrStyle: TextStyle(
                                color: Colors.indigo,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Task Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                            child:
                                Text('${startTime.hour}:${startTime.minute}')),
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
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: colors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    setState(() {
                                      selectedColor = 0xFF00FF00;
                                      print('цвет grenn');
                                    });
                                  } else if (index == 1) {
                                    setState(() {
                                      selectedColor = 0xFFFF0000;
                                    });
                                  } else if (index == 2) {
                                    setState(() {
                                      selectedColor = 0xFF0000FF;
                                    });
                                  } else {
                                    setState(() {
                                      selectedColor = 0xFFFFFF00;
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                    radius: 15, backgroundColor: colors[index]),
                              ),
                            );
                          }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          locator<TaskService>().addTodo(TaskData(
                              taskName: nameController.text,
                              startTimeHour: startTime.hour,
                              endTimeMinute: endTime.minute,
                              colorValue: selectedColor,
                              date: _selectedDay,
                              endTimeHour: endTime.hour,
                              startTimeMinute: startTime.minute));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(selectedColor)),
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
