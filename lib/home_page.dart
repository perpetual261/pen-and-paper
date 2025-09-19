import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pen/themes/app_theme.dart';
import 'package:pen/widgets/to_do_dialog.dart';
import 'package:pen/widgets/to_do_tile.dart';

import 'models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box<Todo> todoBox = Hive.box<Todo>('todos');
  final List<Todo> _todos = [
    Todo('Do Exercise', colorIndex: 0, taskCompleted: false),
    Todo('Code and Practice', colorIndex: 1, taskCompleted: false),
  ];

  final List<Color> _colors = [
    Colors.red.shade400,
    Colors.green,
    Colors.deepPurple,
    Colors.cyan,
    Colors.amber,
  ];

  int _nextColorIndexForNewTodo() => todoBox.length % _colors.length;

  final TextEditingController _taskcontroller = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return ToDoDialog(
          title: Text('Add New Task'),
          controller: _taskcontroller,
          onAdd: () {
            final text = _taskcontroller.text;
            if (_taskcontroller.text.trim().isNotEmpty) {
              // setState(() {
              Hive.box<Todo>('todos').add(
                Todo(
                  _taskcontroller.text,
                  colorIndex: _nextColorIndexForNewTodo(),
                  taskCompleted: false,
                ),
              );
              //todoBox.add(text);
              //  });
              _taskcontroller.clear();
            }
          },
        );
      },
    );
  }

  void checkBoxValue(bool? value, int index) {
    final todo = todoBox.getAt(index);
    if (todo != null) {
      todo.taskCompleted = value ?? false;
      todo.save();
    }

    // setState(() {
    //   _todos[index].taskCompleted = value ?? false;
    // });
  }

  @override
  void dispose() {
    _taskcontroller.dispose();
    super.dispose();
  }

  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        foregroundColor: AppColor.secondary,
        onPressed: _addTodo,
        backgroundColor: AppColor.primary,
        child: Icon(Icons.add, size: 27),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primary),
        backgroundColor: Colors.white.withValues(alpha: 0.90),
        title: RichText(
          text: TextSpan(
            text: 'Welcome  ',
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
            children: [TextSpan(text: 'USER', style: AppTextStyle.headline)],
          ),
        ),
      ),
      drawer: Drawer(backgroundColor: Colors.white70),
      backgroundColor: Colors.transparent,
      body: TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          begin: toggle ? Colors.blue : Colors.tealAccent,
          end: toggle ? Colors.tealAccent : Colors.blue,
        ),
        duration: const Duration(seconds: 3),
        onEnd: () {
          setState(() {
            toggle = !toggle;
          });
        },
        builder: (context, color, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color ?? Colors.tealAccent,
                  toggle ? Colors.white : Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: todoBox.length,
                  itemBuilder: (context, index) {
                    final todo = todoBox.getAt(index)!;
                    final color = _colors[todo.colorIndex % _colors.length];
                    return ToDoTile(
                      name: todo.name,
                      color: color,
                      taskCompleted: todo.taskCompleted,
                      onChanged: (value) {
                        return checkBoxValue(value, index);
                      },
                      onEdit: () {
                        _taskcontroller.text = todo.name;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ToDoDialog(
                              title: Text('Edit Task'),
                              controller: _taskcontroller,
                              onAdd: () {
                                final newTodo = _taskcontroller.text.trim();
                                if (newTodo.isNotEmpty) {
                                  // setState(() {
                                  todo.name = newTodo;
                                  todo.save();
                                  //});
                                }
                              },
                            );
                          },
                        );
                      },
                      onDelete: () {
                        //   setState(() {
                        todoBox.deleteAt(index);
                        // });
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
