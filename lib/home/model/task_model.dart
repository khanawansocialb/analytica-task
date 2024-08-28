import 'dart:core';
import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskModel extends Equatable {
  final String id;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final String title;
  final String description;
  final bool isCompleted;
  String? category = 'General';
  final DateTime? dueDate;
  final DateTime? reminder;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.category,
    this.dueDate,
    this.reminder,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, userId, title, description, isCompleted, category, dueDate, reminder];
}
