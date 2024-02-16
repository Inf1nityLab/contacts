import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app_hive/locator.dart';
import '../model/to_do_model.dart';
import '../service/to_service.dart';

class ToDoNewProject extends StatelessWidget {
  ToDoNewProject({super.key});

  final ToDoService _todoService = locator<ToDoService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _todoService.getAllTodos(),
      builder: (context, AsyncSnapshot<List<ToDoModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TodoListPage(snapshot.data ?? []);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class TodoListPage extends StatefulWidget {
  final List<ToDoModel> todos;

  TodoListPage(
    this.todos,
  );

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final ToDoService _todoService = locator<ToDoService>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive TODO List"),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ToDoModel>('Tasks').listenable(),
        builder: (context, Box<ToDoModel> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(todo!.name),
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (val) {
                    _todoService.toggleCompleted(index, todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _todoService.deleteTodo(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Todo'),
                  content: TextField(
                    controller: _controller,
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text('Add'),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          var todo = ToDoModel(
                            _controller.text,
                          );
                          _todoService.addTodo(todo);
                          _controller.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
