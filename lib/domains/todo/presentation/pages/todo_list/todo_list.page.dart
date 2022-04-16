// Copyright 2022 Eray Erdin.
// Use of this source code is governed by the WTFPL
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';
import 'package:todos_bloc_freezed/domains/todo/logic/todo_bloc_freezed/todo_bloc.dart';
import 'package:todos_bloc_freezed/domains/todo/presentation/components/todo_card/todo_card.component.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // same as below
        // final todoBloc = TodoBloc();
        // todoBloc.add(TodoEvent.list());
        // return todoBloc;

        return TodoBloc()..add(const TodoEvent.list());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          // with this, if we ever add a new state to TodoState
          // we will get a compile time error
          // thus avoiding unhandled state cases
          builder: (context, state) => state.map(
            processing: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
            list: (state) => state.todos.isEmpty
                // if todos is empty, show a message
                ? const Center(child: Text('No todos'))
                // otherwise, show a list of todos
                : ListView.separated(
                    // create a TodoCardComponent with todo at `index`
                    itemBuilder: (context, index) =>
                        TodoCardComponent(todo: state.todos[index]),
                    // separate items
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    // how many todos are there
                    itemCount: state.todos.length,
                  ),
          ),
        ),
        floatingActionButton: const _CreateTodoButton(),
      ),
    );
  }
}

class _CreateTodoButton extends StatelessWidget {
  const _CreateTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // go to todo creation page and wait for result
        final Todo? todo =
            await Navigator.of(context).pushNamed('/create') as Todo?;

        if (todo != null) {
          // add a new create event to bloc
          BlocProvider.of<TodoBloc>(context).add(TodoEvent.create(todo));
        } else {
          // if todo is null, tell a message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You have cancelled the operation.'),
            ),
          );
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
