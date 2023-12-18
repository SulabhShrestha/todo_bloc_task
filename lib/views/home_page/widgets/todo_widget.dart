import 'package:flutter/material.dart';
import 'package:todo_bloc_task/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc_task/models/todo_model.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel todoModel;
  final TodoBloc todoBloc;
  const TodoWidget({
    super.key,
    required this.todoBloc,
    required this.todoModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todoModel.task),
      // edit and delete button
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              // showing edit dialog
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController _editTodoController =
                      TextEditingController();
                  return AlertDialog(
                    title: const Text('Edit Todo'),
                    content: TextField(
                      controller: _editTodoController,
                      decoration: InputDecoration(
                        hintText: todoModel.task,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          todoBloc.add(TodoUpdateEvent(
                            id: todoModel.id,
                            task: _editTodoController.text,
                          ));
                          Navigator.pop(context);
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              todoBloc.add(TodoDeleteEvent(id: todoModel.id));
            },
            color: Colors.red,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
