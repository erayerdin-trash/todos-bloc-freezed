import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';
import 'package:todos_bloc_freezed/domains/todo/data/repositories/todo.repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

// this bloc almost does the same as freezed variation
// this bloc is not used in the project
// just for demonstration

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository = DummyTodoRepository();

  TodoBloc() : super(ProcessingTodosState()) {
    on<TodoEvent>((event, emit) async {
      // we create an if-else chain with each implementation of `TodoEvent`

      // if we were to add a new event to `todo_event.dart`,
      // then we would not get a compile time error here
      // which means we would not handle this event at all

      // the same goes for each `TodoState`s
      // if we were to add a new state to `todo_state.dart`,
      // then we would not get a compile time error in wherever we use the state
      // that might be in any pages or components or any custom widget
      // anywhere in the project
      // that would cause unhandled states
      // thus unavoidable bugs

      // to keep it short, freezed lets us to have compile time errors
      // when we add a new event or state
      // so we can handle them in the project with confidence

      if (event is CreateTodoEvent) {
        emit(ProcessingTodosState());
        await _todoRepository.create(event.todo);
        add(ListTodosEvent());
      } else if (event is DeleteTodoEvent) {
        emit(ProcessingTodosState());
        await _todoRepository.delete(event.todo);
        add(ListTodosEvent());
      } else if (event is ListTodosEvent) {
        emit(ProcessingTodosState());
        final todos = await _todoRepository.list().toList();
        emit(ListTodosState(todos: todos));
      }
    });
  }
}
