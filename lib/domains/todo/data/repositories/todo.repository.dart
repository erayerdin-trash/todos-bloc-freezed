// Copyright 2022 Eray Erdin.
// Use of this source code is governed by the WTFPL
// license that can be found in the LICENSE file.

import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';

abstract class TodoRepository {
  Future<void> create(Todo todo);
  Future<void> delete(Todo todo);
  Stream<Todo> list();
}

class DummyTodoRepository extends TodoRepository {
  List<Todo> _dummyTodoData = [];

  @override
  Future<void> create(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2)); // fake wait
    _dummyTodoData = [..._dummyTodoData, todo];
  }

  @override
  Future<void> delete(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2)); // fake wait
    _dummyTodoData = _dummyTodoData.where((t) => t.id != todo.id).toList();
  }

  @override
  Stream<Todo> list() async* {
    await Future.delayed(const Duration(seconds: 2)); // fake wait
    for (final todo in _dummyTodoData) {
      yield todo;
    }
  }
}
