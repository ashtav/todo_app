import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/data/api/api.dart';

import '../../data/models/todo1.dart';

class TodoDetailNotifier extends StateNotifier<AsyncValue<Todo1>> with UseApi {
  final int todoId;
  TodoDetailNotifier({required this.todoId}) : super(AsyncValue.data(Todo1())) {
    getTodo();
  }

  Future getTodo() async {
    try {
      state = const AsyncValue.loading();
      final res = await todoApi.getTodoDetail(todoId);

      if (res.statusCode == 200) {
        final map = json.decode(res.data);
        state = AsyncValue.data(Todo1.fromJson(map));
      }
    } catch (e, s) {
      print('Error: $e, $s');
    }
  }
}

final todoDetailProvider =
    StateNotifierProvider.autoDispose.family<TodoDetailNotifier, AsyncValue<Todo1>, int>((ref, todoId) {
  return TodoDetailNotifier(todoId: todoId);
});
