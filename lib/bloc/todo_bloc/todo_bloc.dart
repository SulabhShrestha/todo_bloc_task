import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_task/data/todo_data.dart';
import 'package:todo_bloc_task/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoAddEvent>((event, emit) {
      TodoData.todos.add({
        "id": event.id,
        "task": event.task,
      });
      log("Adding todo");

      emit(TodoLoadedSuccessState(
          todos: TodoData.todos
              .map((e) => TodoModel(id: e["id"], task: e["task"]))
              .toList()));
    });

    on<TodoDeleteEvent>((event, emit) {
      log("Deleting todo");
      TodoData.todos.removeWhere((element) => element["id"] == event.id);

      emit(TodoLoadedSuccessState(
          todos: TodoData.todos
              .map((e) => TodoModel(id: e["id"], task: e["task"]))
              .toList()));
    });

    on<TodoUpdateEvent>((event, emit) {
      log("Updating todo");

      // updating the data
      TodoData.todos[
              TodoData.todos.indexWhere((element) => element["id"] == event.id)]
          ["task"] = event.task;

      emit(TodoLoadedSuccessState(
          todos: TodoData.todos
              .map((e) => TodoModel(id: e["id"], task: e["task"]))
              .toList()));
    });

    on<TodoFetchEvent>((event, emit) async {
      emit(TodoLoadingState());

      await Future.delayed(Duration(seconds: 3));

      // adding to the state
      List<TodoModel> todos = [];

      TodoData.todos
          .map((e) => todos.add(TodoModel(id: e["id"], task: e["task"])))
          .toList();

      emit(TodoLoadedSuccessState(todos: todos));

      log("Fetching todo");
    });
  }
}
