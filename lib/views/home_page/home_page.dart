import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_task/models/todo_model.dart';

import '../../bloc/todo_bloc/todo_bloc.dart';
import 'widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoBloc _todoBloc = TodoBloc();
  final TextEditingController _todoController = TextEditingController();
  final FocusNode _todoFocusNode = FocusNode();

  @override
  void initState() {
    _todoBloc.add(TodoFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today Task'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<TodoBloc, TodoState>(
              bloc: _todoBloc,
              builder: (context, state) {
                log("State: $state");
                if (state is TodoLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TodoLoadedSuccessState) {
                  if (state.todos.isEmpty) {
                    return const Text("No todos");
                  }

                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return TodoWidget(
                        todoBloc: _todoBloc,
                        todoModel: state.todos[index],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
              listener: (BuildContext context, TodoState state) {},
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _todoController,
                  focusNode: _todoFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter task",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _todoBloc.add(TodoAddEvent(
                    id: DateTime.now().millisecondsSinceEpoch,
                    task: _todoController.text,
                  ));

                  // Clearing and unfocusing the textfield
                  _todoController.clear();
                  _todoFocusNode.unfocus();
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
