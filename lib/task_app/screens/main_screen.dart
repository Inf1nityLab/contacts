import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  bool name = true;

  void done(){
    setState(() {
      name = !name;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
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
                //`selectedDate` the new date selected.
              },
              headerProps: const EasyHeaderProps(

                showMonthPicker: false,
                monthPickerType: MonthPickerType.dropDown,
                dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
                  selectedDateStyle: TextStyle(color: Colors.white)
              ),
              dayProps: const EasyDayProps(
                dayStructure: DayStructure.dayStrDayNum,
                width: 70,
                height: 90,
                inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.all(Radius.circular(25)),

                  ),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
              child: containerBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerBody() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's tasks"),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                             CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.indigo,
                              child: Center(
                                child: name ? const Icon(Icons.done, size: 15,color: Colors.white) : const CircleAvatar(
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
                                  color: Colors.indigo,
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '09:00 - 10:30',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const Text('Coffee with Julia'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('1.5 hours'),
                                      ElevatedButton(
                                          onPressed: () {
                                            done();
                                          },
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
                }),
          )
        ],
      ),
    );
  }
}
