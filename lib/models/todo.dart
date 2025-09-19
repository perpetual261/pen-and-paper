import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool taskCompleted;

  @HiveField(2)
  int colorIndex;

  Todo(this.name, {this.taskCompleted = false, this.colorIndex = 0});
}
