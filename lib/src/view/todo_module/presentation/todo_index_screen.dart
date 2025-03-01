import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider.dart';
import 'todo_add_screen.dart';

class TodoIndexScreen extends StatelessWidget {
  const TodoIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TodoAddScreen()));
        },
      ),
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          if (value.getTodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total todo today : ${value.getListTodo.length} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              value.getListTodo.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'No todo list available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: value.getListTodo.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                  child: Text((index + 1).toString())),
                              title: Text(
                                value.getListTodo[index].activity.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RM ${value.getListTodo[index].price.toString()}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Type : ${value.getListTodo[index].type.toString()}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Accessibility todo : ${value.getListTodo[index].accessibility.toString()}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        value.getListTodo[index]
                                                    .bookingRequired !=
                                                false
                                            ? Icons.done
                                            : Icons.close,
                                        color: value.getListTodo[index]
                                                    .bookingRequired !=
                                                false
                                            ? Colors.green
                                            : Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(value.getListTodo[index]
                                                  .bookingRequired !=
                                              false
                                          ? 'Booking Required'
                                          : 'No Booking Required'),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    value.deleteSingleTodoList(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outlined,
                                    color: Colors.red,
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
