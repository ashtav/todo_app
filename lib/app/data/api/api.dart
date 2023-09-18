library api;

import 'package:fetchly/fetchly.dart';

part 'auth_api.dart';
part 'todo_api.dart';

mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
}
