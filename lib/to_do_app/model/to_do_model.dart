import 'package:hive/hive.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 1)
class ToDoModel{
  @HiveField(0)
  final String name;
  @HiveField(1)
  bool isComplete;

  ToDoModel( this.name,  {this.isComplete = false} );
}




