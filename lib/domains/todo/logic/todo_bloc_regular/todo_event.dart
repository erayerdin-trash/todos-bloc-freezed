part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final Todo todo;

  CreateTodoEvent({
    required this.todo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateTodoEvent && other.todo == todo;
  }

  @override
  int get hashCode => todo.hashCode;
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent({
    required this.todo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteTodoEvent && other.todo == todo;
  }

  @override
  int get hashCode => todo.hashCode;
}

class ListTodosEvent extends TodoEvent {}
