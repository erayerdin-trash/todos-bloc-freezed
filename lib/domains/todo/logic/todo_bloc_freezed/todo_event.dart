part of 'todo_bloc.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.create(Todo todo) = _CreateEvent;
  const factory TodoEvent.delete(Todo todo) = _DeleteEvent;
  const factory TodoEvent.list() = _ListEvent;
}
