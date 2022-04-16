// Copyright 2022 Eray Erdin.
// Use of this source code is governed by the WTFPL
// license that can be found in the LICENSE file.

class Todo {
  final String id;
  final String content;

  const Todo({
    required this.id,
    required this.content,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo && other.id == id && other.content == content;
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode;
}

// you can also create your models with freezed if they have different variants
// you can also get the equality for free
// however, this is out of the scope of this project