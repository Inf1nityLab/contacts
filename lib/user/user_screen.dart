
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_app_hive/user/user_data.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<List<User>> fetchUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

    if (response.statusCode == 200) {
      // Парсинг JSON
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      // Обработка ошибки
      throw Exception('Failed to load user');
    }
  }

  String name = 'Hello';
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;
            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing:  ElevatedButton(onPressed: (){age.toString();}, child: Text('Hello'),),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // Show loading indicator
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
