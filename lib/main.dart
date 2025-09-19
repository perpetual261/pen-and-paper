import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pen/models/todo.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  final todoBox = await Hive.openBox<Todo>('todos');

  if (todoBox.isEmpty) {
    todoBox.addAll([
      Todo('Do Exercise', colorIndex: 0, taskCompleted: false),
      Todo('Code and Practice', colorIndex: 1, taskCompleted: false),
    ]);
  }

  await Hive.openBox<Todo>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: HomePage(),
    );
  }
}
