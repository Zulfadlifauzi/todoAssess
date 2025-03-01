import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoassessment/src/view/todo_module/provider/todo_provider.dart';

import 'src/view/todo_module/presentation/todo_index_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider()..getTodoList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoIndexScreen(),
      ),
    );
  }
}
