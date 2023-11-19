
import 'package:app/model/task.dart';
import 'package:app/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void createTask(Task task) async {
    await _taskService.createTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  void getTasks(String userId) async {
    _tasks = await _taskService.getTasks(userId);
    notifyListeners();
  }
  
  void updateTask(Task task) async {
    await _taskService.updateTask(task);
    _tasks = _tasks.map((t) {
      if (t.id == task.id) {
        return task;
      } else {
        return t;
      }
    }).toList();
    notifyListeners();
  }

  void deleteTask(String id) async {
    await _taskService.deleteTask(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

}
