import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/Todo.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final todo=Provider.of<Todo>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  todo.todos.map((elt){
        return ListTile(
          title: Text(elt,
            style: const TextStyle(fontSize: 17),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                todo.removeTask(elt);
              });
            },
            icon: const Icon(Icons.remove_circle),
          ),
        );
      }).toList(),
    );
  }
}
