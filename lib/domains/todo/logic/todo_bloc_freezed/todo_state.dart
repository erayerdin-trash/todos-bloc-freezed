part of 'todo_bloc.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.processing() = _ProcessingState;
  const factory TodoState.list(List<Todo> todos) = _ListState;
}
