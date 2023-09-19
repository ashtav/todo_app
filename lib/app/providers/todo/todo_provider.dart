import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/data/api/api.dart';

import '../../data/models/todo.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  TodoNotifier() : super(const AsyncValue.data([]));

  Future getTodos() async {
    state = const AsyncValue.loading();
    ResHandler res = await todoApi.getTodos();
    List data = res.data?['data'] ?? [];
    state = AsyncValue.data(data.map((e) => Todo.fromJson(e)).toList());
  }
}

final todoProvider = StateNotifierProvider.autoDispose<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodoNotifier();
});
