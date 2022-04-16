// Copyright 2022 Eray Erdin.
// Use of this source code is governed by the WTFPL
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:todos_bloc_freezed/domains/todo/data/models/todo.model.dart';

// this is a stateful widget
// because we want to keep track of content TextField value
class TodoCreatePage extends StatefulWidget {
  const TodoCreatePage({Key? key}) : super(key: key);

  @override
  State<TodoCreatePage> createState() => _TodoCreatePageState();
}

class _TodoCreatePageState extends State<TodoCreatePage> {
  // the controller is used to keep track of the content TextField value
  final _contentTextFieldController = TextEditingController();

  // dispose controller so that we don't cause memory leak
  @override
  void dispose() {
    _contentTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Todo'),
      ),
      body: Padding(
        // a padding to make the form look nice
        padding: const EdgeInsets.all(8.0),
        // form elements
        child: Column(
          children: [
            // the field for content of todo
            TextField(
              decoration: const InputDecoration(
                labelText: 'Todo Content',
              ),
              // inject the controller so we can read it later on
              controller: _contentTextFieldController,
            ),
          ],
        ),
      ),
      // if this button is pressed, the todo is created
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // return to the previous page
          // also return some data
          Navigator.of(context).pop<Todo?>(
            Todo(
              // use now as id
              // it is not important to have id in this project
              // this is only to easily discriminate a todo when deleting it
              id: DateTime.now().toIso8601String(),
              // get the text from the controller
              content: _contentTextFieldController.text,
            ),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
