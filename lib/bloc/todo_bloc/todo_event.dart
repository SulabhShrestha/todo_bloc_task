part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final int id;
  final String task;

  TodoAddEvent({
    required this.id,
    required this.task,
  });
}

class TodoDeleteEvent extends TodoEvent {
  final int id;

  TodoDeleteEvent({
    required this.id,
  });
}

class TodoUpdateEvent extends TodoEvent {
  final int id;
  final String task;

  TodoUpdateEvent({
    required this.id,
    required this.task,
  });
}

class TodoFetchEvent extends TodoEvent {}
