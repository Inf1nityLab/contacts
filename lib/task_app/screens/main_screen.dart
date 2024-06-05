import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:to_do_app_hive/locator.dart';
import 'package:to_do_app_hive/task_app/model/task_data.dart';
import 'package:to_do_app_hive/task_app/screens/add_screen.dart';
import 'package:to_do_app_hive/task_app/service/task_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddScreen()));
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [Text('Hello'), Icon(Icons.ac_unit)],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {

                  setState(() {
                    selectedDay = selectedDate;
                    print('$selectedDay');
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
                    borderRadius: BorderRadius.all(Radius.circular(25)),
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
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
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
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: FutureBuilder(
                future: locator<TaskService>().getAllTask(),
                builder: (context, AsyncSnapshot<List<TaskData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ContainerBody(
                      snapshot.data ?? [],
                      selectedDay
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerBody extends StatefulWidget {
  final List<TaskData> contacts;
  DateTime selectedDayOne ;

  ContainerBody(this.contacts, this.selectedDayOne);

  @override
  State<ContainerBody> createState() => _ContainerBodyState();
}

class _ContainerBodyState extends State<ContainerBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's tasks"),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<TaskData>('taskData').listenable(),
              builder: (context, Box<TaskData> box, _) {
                return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      var _task = box.get(index);
                      DateTime selectedDay = widget.selectedDayOne;
                      if (_task!.date.year == selectedDay.year &&
                          _task!.date.month == selectedDay.month &&
                          _task!.date.day == selectedDay.day) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                   CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(_task.colorValue),
                                    child: const Center(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 5,
                                      ),
                                    ),
                                  ),
                                  for (int i = 0; i < 10; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        height: 3,
                                        width: 3,
                                        color: Color(_task.colorValue),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(_task!.colorValue),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_task!.startTimeHour}:${_task.startTimeMinute}  - ${_task.endTimeHour}:${_task.endTimeMinute} ',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(_task!.taskName),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('1.5 hours'),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text('Done'))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else{
                        return Container();
                      }
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
