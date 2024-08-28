import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/config/app_size.dart';
import 'package:the_app/home/cubit/task_cubit.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> with SingleTickerProviderStateMixin {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  DateTime? reminderDate;
  DateTime? dueDate;
  bool _isTaskAdded = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.appHeight / 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(hintText: "Category"),
                ),
                SizedBox(
                  width: AppSize.appWidth / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Add Reminder"),
                      IconButton(
                          onPressed: () async {
                            reminderDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2040));
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                ),
                SizedBox(
                  width: AppSize.appWidth / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Set Due Date"),
                      IconButton(
                          onPressed: () async {
                            dueDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2040));
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskCubit>().addTask(
                        title: titleController.text,
                        description: descriptionController.text,
                        dueDate: dueDate,
                        reminder: reminderDate);

                    setState(() {
                      _isTaskAdded = true;
                      _controller.forward(from: 0.0);
                    });

                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Add Task"),
                ),
              ],
            ),
          ),
          if (_isTaskAdded)
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

