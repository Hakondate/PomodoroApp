import 'package:flutter/material.dart';
import 'package:pomodoro_app/model/task_model.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final ValueChanged<TaskModel> onTap;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Text('タスクがありません');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return ListTile(
          title: Text(task.title),
          onTap: () => onTap(task),
        );
      },
    );
  }
}
