import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> saveTask(String taskName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.add(taskName);
    await prefs.setStringList('tasks', tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String taskName = _taskController.text;
                if (taskName.isNotEmpty) {
                  await saveTask(taskName);
                  setState(() {}); 
                }
                Navigator.pop(context); 
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
