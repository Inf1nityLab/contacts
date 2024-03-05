



import 'package:hive/hive.dart';
import 'package:to_do_app_hive/task_app/model/task_data.dart';

class TaskService{


  Future<Box<TaskData>> get _box async => await Hive.openBox<TaskData>('taskData');


  //Create
  Future<void> addTodo(TaskData taskData) async {
    var task = await _box;
    await task.add(taskData);
  }


  // Read
  Future<List<TaskData>> getAllTask() async {
    var task = await _box;
    return task.values.toList();
  }




  // Delete
  // Future<void> deleteTodo(int index) async {
  //   var task = await _box;
  //   await task.deleteAt(index);
  // }

  // check
  // Future<void> toggleCompleted(int index, ToDoModel item) async {
  //   var task = await _box;
  //   item.isComplete = !item.isComplete;
  //   await task.putAt(index, item);
  // }
}