import 'package:hive/hive.dart';
import '../model/to_do_model.dart';

class ToDoService{

  final String _task = "Tasks";

  Future<Box<ToDoModel>> get _box async => await Hive.openBox<ToDoModel>(_task);




  //Create
  Future<void> addTodo(ToDoModel item) async {

    var task = await _box;
    await task.add(item);
  }



  // Read
  Future<List<ToDoModel>> getAllTodos() async {
    var task = await _box;
    return task.values.toList();
  }




  // Delete
  Future<void> deleteTodo(int index) async {
    var task = await _box;
    await task.deleteAt(index);
  }

  // check
  Future<void> toggleCompleted(int index, ToDoModel item) async {
    var task = await _box;
    item.isComplete = !item.isComplete;
    await task.putAt(index, item);
  }
}