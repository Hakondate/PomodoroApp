import 'package:flutter/material.dart';
import 'package:pomodoro_app/view/todo/todo.dart';
import 'package:pomodoro_app/view/timer/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pomodoro App'),
        ),
        body: Column(
          children: [
            Timer(),
            SizedBox(height: 20),
            Expanded(child: TodoFunction()),
          ],
        ),
      ),
    );
  }
}
