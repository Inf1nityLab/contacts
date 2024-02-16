import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
          const SizedBox(
            height: 100,
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

  Widget containerBody(){
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's tasks"),
          Expanded(
            child: ListView.builder(itemCount: 10,itemBuilder: (context, index){
              return ListTile(
                title: Text('$index'),
              );
            }),
          )
        ],
      ),
    );
  }
}
