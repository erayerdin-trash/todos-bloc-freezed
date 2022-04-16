// Copyright 2022 Eray Erdin.
// Use of this source code is governed by the WTFPL
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';
import 'package:todos_bloc_freezed/domains/todo/logic/todo_bloc_freezed/todo_bloc.dart';

class TodoCardComponent extends StatelessWidget {
  final Todo todo;

  const TodoCardComponent({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // content of todo
            Text(todo.content),
            // delete button
            IconButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(TodoEvent.delete(todo));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
