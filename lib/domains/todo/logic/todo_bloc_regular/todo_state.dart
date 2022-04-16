part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class ProcessingTodosState extends TodoState {}

class ListTodosState extends TodoState {
  final List<Todo> todos;

  ListTodosState({
    required this.todos,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListTodosState && listEquals(other.todos, todos);
  }

  @override
  int get hashCode => todos.hashCode;
}
