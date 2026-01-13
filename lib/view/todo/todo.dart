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
  bool showCompleted = false;

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
  void addTask() async {
    final TextEditingController controller = TextEditingController();
    final String? title = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('タスクを追加'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'タスク名を入力',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.pop(context, controller.text.trim());
                }
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );

    if (title == null) return;

    setState(() {
      tasks.add(
        TaskModel(
          id: nextId++,
          title: title,
          isCompleted: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleTasks =
        tasks.where((t) => t.isCompleted == showCompleted).toList();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: const Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
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
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showCompleted = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: showCompleted ? Colors.grey[300] : Colors.orange,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '未着手',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showCompleted = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: showCompleted ? Colors.orange : Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '完了',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TaskList(
              tasks: visibleTasks,
              onTap: (task) {
                if (!showCompleted) {
                  setState(() {
                    currentTask = task;
                  });
                }
              },
            ),
          ),

          // タスク追加ボタン
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: addTask,
              child: const Text(
                '追加する',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
