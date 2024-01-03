import 'package:go_router/go_router.dart';
import 'package:todo_app/app/screens/home/views/home_page.dart';
import 'package:todo_app/app/screens/login/views/login_view.dart';
import 'package:todo_app/app/screens/todo/views/form_todo_view.dart';

import '../data/models/todo.dart';
import '../data/services/local/storage.dart';
import 'helper.dart';
import 'paths.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    Route.set(Paths.home, (state) => const HomePage(), redirect: (_) => _redirect()),
    Route.set(Paths.login, (state) => const LoginView()),
    Route.set(Paths.formTodo, (state) => FormTodoView(data: state.extra as Todo?)),
  ],
);

String _redirect() {
  String? token = prefs.getString('token');
  return token == null ? Paths.login : Paths.home;
}
