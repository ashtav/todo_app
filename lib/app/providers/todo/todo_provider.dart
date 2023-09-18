import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/data/api/api.dart';

import '../../data/models/todo.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  TodoNotifier() : super(const AsyncValue.data([]));

  Future getTodos() async {
    ResHandler res = await todoApi.getTodos();
    List data = res.data ?? [];

    logg(data);
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, AsyncValue>((ref) {
  return TodoNotifier();
});
