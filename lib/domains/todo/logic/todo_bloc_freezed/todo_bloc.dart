import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';
import 'package:todos_bloc_freezed/domains/todo/data/repositories/todo.repository.dart';

part 'todo_bloc.freezed.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // would be better with `get_it` dependency injection
  // but that's out of scope of this project
  final TodoRepository _todoRepository = DummyTodoRepository();

  // our initial state is processing state
  // so the page can show a fake circular progress indicator
  TodoBloc() : super(const TodoState.processing()) {
    // needs to be async because we are using the future in todo repository
    on<TodoEvent>((event, emit) async {
      // here we have our events and how we handle them
      // if you were to add a new event to `todo_event.dart`,
      // then you will get an error here
      // which is good because you have to implement all the events

      // we need to await the requested event
      await event.map(
        create: (event) async {
          // to show circular progress indicator
          emit(const TodoState.processing());

          // here we are calling the repository to create a new todo
          // and we are NOT EMITTING A STATE but ADDING A NEW EVENT
          // we need to trigger list event again to update the list
          await _todoRepository.create(event.todo);
          add(const TodoEvent.list());
        },
        delete: (event) async {
          // to show circular progress indicator
          emit(const TodoState.processing());

          // here we are calling the repository to delete a todo
          // and we are NOT EMITTING A STATE but ADDING A NEW EVENT
          // we need to trigger list event again to update the list
          await _todoRepository.delete(event.todo);
          add(const TodoEvent.list());
        },
        list: (event) async {
          // to show circular progress indicator
          emit(const TodoState.processing());

          // here we are calling the repository to get all todos
          // and we are NOT EMITTING A STATE but ADDING A NEW EVENT
          // we need to trigger list event again to update the list
          final todos = await _todoRepository.list().toList();
          emit(TodoState.list(todos));
        },
      );
    });
  }
}
