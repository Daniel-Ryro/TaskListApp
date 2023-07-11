import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  Future<void> refreshTasks() async {
    // Simulate loading tasks from a remote source or perform any asynchronous operation
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // Reload tasks
      loadTasks();
    });
  }

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
    saveTasks();
  }

  void removeTask(String task) {
    setState(() {
      tasks.remove(task);
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshTasks,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tasks[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removeTask(tasks[index]);
                  refreshTasks(); // Atualiza a lista após remover uma tarefa
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await Navigator.pushNamed<String>(context, '/addTask');
          if (task != null) {
            addTask(task);
            refreshTasks(); // Atualiza a lista após adicionar uma tarefa
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
