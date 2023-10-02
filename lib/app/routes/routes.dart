import 'package:go_router/go_router.dart';
import 'package:todo_app/app/screens/home/views/home_page.dart';
import 'package:todo_app/app/screens/login/views/login_view.dart';
import 'package:todo_app/app/screens/todo/views/form_todo_view.dart';

import '../data/services/local/storage.dart';
import 'paths.dart';
import 'extension.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    const HomePage().route(Paths.home, redirect: (_, __) => _redirect()),
    const LoginView().route(Paths.login),
    const FormTodoView().route(Paths.formTodo),
  ],
);

String _redirect() {
  String? token = prefs.getString('token');
  return token == null ? Paths.login : Paths.home;
}
