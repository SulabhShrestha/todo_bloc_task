part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoLoadedSuccessState extends TodoState {
  final List<TodoModel> todos;

  TodoLoadedSuccessState({required this.todos});
}

class TodoLoadedFailedState extends TodoState {}
