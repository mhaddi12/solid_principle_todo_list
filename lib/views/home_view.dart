import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Function/function.dart';
import '../model/todo_list_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<TodoList>? todoBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  _initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoListAdapter());
    todoBox = await Hive.openBox<TodoList>("my_box");
    setState(() {}); // Refresh the UI after the box is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        elevation: 2,
      ),
      body: SafeArea(
        child: todoBox == null
            ? const Center(child: CircularProgressIndicator())
            : _buildTodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList() {
    final readTodo = ReadTodo(todoBox!);
    final todos = readTodo.readTodo();

    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos available'),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Slidable(
          startActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: (value) {
                setState(() {
                  final delete = TodoDelete(todoBox!);
                  delete.deleteTodo(index);
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 0.5, color: Colors.purpleAccent),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                todo.title,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  decoration: todo.check ?? false
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                value: todo.check ?? false,
                onChanged: (value) {
                  setState(() {
                    final updateTodo =
                        TodoList(title: todo.title, check: value);
                    final update = UpdateTodo(todoBox!);
                    update.updateTodo(index, updateTodo);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _addTodo() {
    TextEditingController titleController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Todo Title'),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    final todo = TodoList(
                      title: titleController.text,
                      check: false,
                    );
                    todoBox?.add(todo);
                    if (kDebugMode) {
                      print('Todo added: $todo');
                    }
                    Navigator.pop(context); // Close the bottom sheet
                    setState(() {}); // Refresh the UI after adding a new todo
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a title')),
                    );
                  }
                },
                child: const Text('Add Todo'),
              ),
            ],
          ),
        );
      },
    );
  }
}
