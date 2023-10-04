import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/data/api/api.dart';

import '../../data/models/todo.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<Todo>>> with UseApi {
  TodoNotifier() : super(const AsyncValue.data([]));

  final forms = LzForm.make(['title', 'description']);

  Future getTodos() async {
    state = const AsyncValue.loading();
    ResHandler res = await todoApi.getTodos();
    List data = res.data?['data'] ?? [];
    state = AsyncValue.data(data.map((e) => Todo.fromJson(e)).toList());
  }

  Future<bool> submit(int? id) async {
    try {
      final form =
          forms.validate(required: ['title'], messages: FormMessages(required: {'title': 'Please type todo name.'}));

      if (form.ok) {

        // it means we are creating new todo
        if (id == null) {
          ResHandler res = await todoApi.createTodo(form.value);

          if (res.status) {
            final todo = Todo.fromJson(res.data ?? {});

            state.whenData((data) {
              data.add(todo);
              state = AsyncValue.data(data);
            });
          }

          return res.status;
        } else{
          // update existing todo
          ResHandler res = await todoApi.updateTodo(form.value, id);
          if (res.status) {
            final todo = Todo.fromJson(res.data ?? {});

            state.whenData((data) {
              data[data.indexWhere((element) => element.id == id)] = todo;
              state = AsyncValue.data(data);
            });
          }

          return res.status;
        }
      }

      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future delete(int id) async {
    try {
      LzToast.overlay('Deleting todo...');
      ResHandler res = await todoApi.deleteTodo(id);

      if(res.status){
        state.whenData((data) {
          data.removeWhere((element) => element.id == id);
          state = AsyncValue.data(data);
        });

        LzToast.show('Todo has been deleted.');
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final todoProvider = StateNotifierProvider.autoDispose<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodoNotifier();
});
