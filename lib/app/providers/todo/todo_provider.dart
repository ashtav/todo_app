import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/core/helpers/toast.dart';
import 'package:todo_app/app/data/api/api.dart';

import '../../data/models/todo.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  TodoNotifier() : super(const AsyncValue.data([]));

  final title = TextEditingController(), description = TextEditingController();

  Future getTodos() async {
    state = const AsyncValue.loading();
    final res = await todoApi.getTodos();

    if (res.statusCode == 200) {
      final map = json.decode(res.data);
      List data = map?['data']?['data'] ?? [];
      state = AsyncValue.data(data.map((e) => Todo.fromJson(e)).toList());
    }
  }

  Future create() async {
    if (title.text.trim().isEmpty || description.text.trim().isEmpty) {
      return Toasts.show('Please fill all the fields');
    }

    final res = await todoApi.createTodo({
      'title': title.text,
      'description': description.text,
    });

    if (res.statusCode == 200) {
      final map = json.decode(res.data);
      final data = map?['data'] ?? {};
      final todo = Todo.fromJson(data);

      state.whenData((value) {
        state = AsyncValue.data([...value, todo]);
      });

      Toasts.show('Todo created successfully');
    }
  }
}

final todoProvider = StateNotifierProvider.autoDispose<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodoNotifier();
});
