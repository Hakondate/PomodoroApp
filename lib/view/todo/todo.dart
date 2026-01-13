import 'package:flutter/material.dart';
import 'package:pomodoro_app/model/task_model.dart';
import 'package:pomodoro_app/view/todo/task_list.dart';

class TodoFunction extends StatefulWidget {
  const TodoFunction({super.key});

  @override
  State<TodoFunction> createState() => _TodoFunctionState();
}

class _TodoFunctionState extends State<TodoFunction> {
  TaskModel? currentTask;
  final List<TaskModel> tasks = [];
  int nextId = 1;

  // タスク完了処理
  void completeCurrentTask() {
    if (currentTask == null) return;

    setState(() {
      final index = tasks.indexWhere((t) => t.id == currentTask!.id);

      if (index != -1) {
        tasks[index] = tasks[index].copyWith(isCompleted: true);
      }

      currentTask = null;
    });
  }

  // タスク追加
  void addTask() {
    setState(() {
      tasks.add(
        TaskModel(
          id: nextId++,
          title: '新しいタスク',
          isCompleted: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 現在実行中タスク
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  currentTask != null
                      ? '現在実行中: ${currentTask!.title}'
                      : '現在実行中: なし',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: currentTask != null ? completeCurrentTask : null,
                child: const Text('完了'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // タスクリスト
          TaskList(
            tasks: tasks.where((t) => !t.isCompleted).toList(),
            onTap: (task) {
              setState(() {
                currentTask = task;
              });
            },
          ),

          const SizedBox(height: 16),

          // タスク追加ボタン
          Center(
            child: ElevatedButton.icon(
              onPressed: addTask,
              icon: const Icon(Icons.add),
              label: const Text('タスク追加'),
            ),
          ),
        ],
      ),
    );
  }
}
