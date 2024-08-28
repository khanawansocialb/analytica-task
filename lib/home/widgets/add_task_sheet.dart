import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/config/app_size.dart';
import 'package:the_app/home/cubit/task_cubit.dart';

class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    DateTime? reminderDate;
    DateTime? dueDate;
    return SizedBox(
      height: AppSize.appHeight / 2,
      child: Padding(
        padding: EdgeInsets.all(20.0),
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
                  const Text(" Add Reminder"),
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
                  const Text("Set Due Dtae"),
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
                  Navigator.pop(context);
                },
                child: const Text("Add Task")),
          ],
        ),
      ),
    );
  }
}
