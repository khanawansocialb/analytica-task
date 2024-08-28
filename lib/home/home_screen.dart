import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/home/cubit/task_cubit.dart';
import 'package:the_app/home/model/task_model.dart';
import 'package:the_app/home/widgets/add_task_sheet.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Tasks')),
      body: BlocBuilder<TaskCubit, List<TaskModel>>(
        builder: (context, tasks) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ExpansionTile(
                title: Text(task.title),
                subtitle: Text(task.dueDate == null ? "no due" : task.dueDate.toString().substring(0, 10)),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    context.read<TaskCubit>().toggleTaskCompletion(task.id);
                  },
                ),
                children: [
                  Text(task.description),
                  Text(task.reminder == null ? "no reminder" : task.dueDate.toString().substring(0, 10)),
                ],
                // onLongPress: () {
                //   context.read<TaskCubit>().deleteTask(task.id);
                // },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) => const AddTaskSheet());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
