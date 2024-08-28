import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:the_app/home/model/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskCubit extends HydratedCubit<List<TaskModel>> {
  TaskCubit() : super([]);

  void addTask(String title, String description) {
    final newTask = TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    emit([...state, newTask]);
  }

  void updateTask(TaskModel updatedTask) {
    final tasks = state.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    emit(tasks);
  }

  void deleteTask(String taskId) {
    final tasks = state.where((task) => task.id != taskId).toList();
    emit(tasks);
  }

  void toggleTaskCompletion(String taskId) {
    final tasks = state.map((task) {
      return task.id == taskId
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(tasks);
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
