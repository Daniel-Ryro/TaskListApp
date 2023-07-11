import 'package:flutter/material.dart';
import 'package:task_list_app/add_screen.dart';
import 'package:task_list_app/task_list_screen.dart';

class TaskListApp extends StatelessWidget {
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TaskListScreen());
      case '/addTask':
        return MaterialPageRoute<String>(builder: (_) => AddTaskScreen());
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }
}
