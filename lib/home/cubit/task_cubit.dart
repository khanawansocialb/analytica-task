import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:the_app/home/model/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskCubit extends HydratedCubit<List<TaskModel>> {
  TaskCubit() : super([]);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addTask({
    required String title,
    String description = '',
    String? category = 'General', 
    DateTime? dueDate,
    DateTime? reminder,
  }) async {
    final newTask = TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
      category: category,
      dueDate: dueDate,
      reminder: reminder,
    );
    emit([...state, newTask]);
    await _syncTaskToFirebase(newTask);
  }

  void updateTask(TaskModel updatedTask) async {
    final tasks = state.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    emit(tasks);
    await _syncTaskToFirebase(updatedTask);
  }

  void deleteTask(String taskId) async {
    final tasks = state.where((task) => task.id != taskId).toList();
    emit(tasks);
    await _deleteTaskFromFirebase(taskId);
  }

  void toggleTaskCompletion(String taskId) async {
    final tasks = state.map((task) {
      return task.id == taskId
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(tasks);
    final task = tasks.firstWhere((task) => task.id == taskId);
    await _syncTaskToFirebase(task);
  }

  Future<void> _syncTaskToFirebase(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).set(task.toJson());
    } catch (e) {
      debugPrint ("an error occurred");
    }
  }

  Future<void> _deleteTaskFromFirebase(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      debugPrint ("an error occurred");
    }
  }
  
  List<TaskModel> searchAllTasks(List<TaskModel> tasks, String searchQuery) {
    if (searchQuery.isEmpty) {
      return tasks;
    }

    final searchLower = searchQuery.toLowerCase();

    return tasks.where((task) {
      final titleLower = task.title.toLowerCase();
      final descriptionLower = task.description.toLowerCase();
      return titleLower.contains(searchLower) || descriptionLower.contains(searchLower);
    }).toList();
  }

  @override
  List<TaskModel> fromJson(Map<String, dynamic> json) {
    return (json['tasks'] as List)
        .map((taskJson) => TaskModel(
              id: taskJson['id'],
              title: taskJson['title'],
              description: taskJson['description'],
              isCompleted: taskJson['isCompleted'],
              category: taskJson['category'],
              dueDate: taskJson['dueDate'] != null
                  ? DateTime.parse(taskJson['dueDate'])
                  : null,
              reminder: taskJson['reminder'] != null
                  ? DateTime.parse(taskJson['reminder'])
                  : null,
            ))
        .toList();
  }

  @override
  Map<String, dynamic> toJson(List<TaskModel> state) {
    return {
      'tasks': state
          .map((task) => {
                'id': task.id,
                'title': task.title,
                'description': task.description,
                'isCompleted': task.isCompleted,
                'category': task.category,
                'dueDate': task.dueDate?.toIso8601String(),
                'reminder': task.reminder?.toIso8601String(),
              })
          .toList(),
    };
  }
}
