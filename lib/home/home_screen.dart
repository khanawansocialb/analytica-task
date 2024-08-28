import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_app/config/theme_cubit.dart';
import 'package:the_app/home/cubit/task_cubit.dart';
import 'package:the_app/home/model/task_model.dart';
import 'package:the_app/home/widgets/add_task_sheet.dart';
import 'package:the_app/home/widgets/quote_widget.dart';

import 'widgets/search_tasks.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'), actions: [IconButton(onPressed: () {
        context.read <ThemeCubit> ().toggleTheme();
      }, icon: const Icon (Icons.star_border))]),
      body: Column(
        children: [
          SearchTasksField(
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const QuoteWidget(),
          BlocBuilder<TaskCubit, List<TaskModel>>(
            builder: (context, tasks) {
              return Builder(
                builder: (context) {
                  final filteredTasks = context.read <TaskCubit> ().searchAllTasks(tasks, _searchQuery);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        return GestureDetector(
                          onLongPress: () {
                            context.read<TaskCubit>().deleteTask(task.id);
                          },
                          child: ExpansionTile(
                            title: Text(task.title),
                            subtitle: Text(task.dueDate == null
                                ? "no due"
                                : task.dueDate.toString().substring(0, 10)),
                            trailing: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(child: child, scale: animation);
                          },
                          child: Checkbox(
                            key: ValueKey<bool>(task.isCompleted),
                            value: task.isCompleted,
                            onChanged: (_) {
                              context.read<TaskCubit>().toggleTaskCompletion(task.id);
                            },
                          ),
                        ),
                            children: [
                              Text(task.description),
                              Text(task.reminder == null
                                  ? "no reminder"
                                  : task.dueDate.toString().substring(0, 10)),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => const AddTaskSheet());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
