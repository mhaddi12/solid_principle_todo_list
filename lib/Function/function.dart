import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../model/todo_list_model.dart';

abstract class TodoAdd {
  void addTodo(TodoList todo);
}

abstract class DeleteTodo {
  void deleteTodo(dynamic index);
}

abstract class TodoRead {
  List<TodoList> readTodo();
}

abstract class TodoUpdate {
  List<TodoList> updateTodo(
    dynamic index,
    TodoList todo,
  );
}

class TodoDelete implements DeleteTodo {
  final Box<TodoList> box;

  TodoDelete(this.box);

  @override
  void deleteTodo(dynamic index) {
    try {
      box.deleteAt(index);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class UpdateTodo implements TodoUpdate {
  final Box<TodoList> box;

  UpdateTodo(this.box);

  @override
  List<TodoList> updateTodo(dynamic index, TodoList todos) {
    try {
      box.putAt(index, todos);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return box.values.toList();
  }
}

class AddTodo implements TodoAdd {
  final Box<TodoList> box;

  AddTodo(this.box);

  @override
  addTodo(TodoList todo) {
    try {
      box.put("todo", todo);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class ReadTodo implements TodoRead {
  final Box<TodoList> box;

  ReadTodo(this.box);

  @override
  List<TodoList> readTodo() {
    try {
      box.get('todo');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return box.values.toList();
  }
}
