import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app_hive/task_app/widget/time_widget.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

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
              child: _containerBody(),
            ),
          )
        ],
      ),
    );
  }

  Widget _containerBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar
          const SizedBox(
            height: 200,
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
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Task name'
            ),
          ),
          const SizedBox(height: 25,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeWidget(text: 'Start time'),
              TimeWidget(text: 'EndTime')
            ],
          )
        ],
      ),
    );
  }
}