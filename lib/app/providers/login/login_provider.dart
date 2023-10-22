// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/core/extensions/dio_extension.dart';
import 'package:todo_app/app/core/helpers/toast.dart';

import '../../data/api/api.dart';
import '../../data/services/local/storage.dart';
import '../../routes/paths.dart';

class Auth with ChangeNotifier, UseApi {
  final email = TextEditingController(text: 'admin@gmail.com'),
      password = TextEditingController(text: 'secret');

  Future login(BuildContext context) async {
    try {
      final res = await authApi.login({
        'email': email.text,
        'password': password.text,
      });

      final map = json.decode(res.data);

      if (map['status'] == false) {
        return Toasts.show(map['message']);
      }

      String? token = map['token'];

      if (token != null) {
        if (!context.mounted) return;

        // set token to dio
        dio.setToken(token);

        // save token to shared preferences
        prefs.setString('token', token);

        // go to home
        context.go(Paths.home);
      }
    } catch (e, s) {
      print('Error: $e, StackTrace: $s');
    } finally {}
  }
}

final authProvider = ChangeNotifierProvider((ref) => Auth());
