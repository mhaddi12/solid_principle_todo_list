import 'package:hive/hive.dart';
part 'todo_list_model.g.dart';

@HiveType(typeId: 1, adapterName: "TodoListAdapter")
class TodoList {
  TodoList({required this.title, required this.check});

  @HiveField(0)
  String title;
  @HiveField(1)
  bool? check;

  @override
  String toString() {
    return "$title: $check";
  }
}


