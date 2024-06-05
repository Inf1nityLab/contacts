import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app_hive/locator.dart';
import 'package:to_do_app_hive/task_app/model/task_data.dart';
import 'package:to_do_app_hive/task_app/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskDataAdapter());
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class NullSafety extends StatefulWidget {
  const NullSafety({super.key});

  @override
  State<NullSafety> createState() => _NullSafetyState();
}

class _NullSafetyState extends State<NullSafety> {
  // ?, ??, ! , var, dynamic
  // +, -, *, \, =
  String name = 'baias';
  String? hello;
  String? server = 'Hello';

  int number = 0709358767;
  Widget icon = const Icon(Icons.add);
  Color color = Colors.teal;
  double height = 300;


  var white = 67.89;
  dynamic one = true;
  double a = 0;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${a}', style: TextStyle(fontSize: 40),),

        ],
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: (){
              setState(() {
                a +=1;
              });
            },
            child: const Text('+'),
          ),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                a -=1;
              });
            },
            child: const Text('-'),
          ),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                a *=2;
              });
            },
            child: const Text('*'),
          ),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                a /=2;
              });
            },
            child: const Text('/'),
          ),
        ],
      )
    );
  }
}



