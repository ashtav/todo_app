import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/services/local/storage.dart';

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['username', 'password']);

  Future<bool> login() async {
    try {
      final form = LzForm.validate(forms, required: ['*']);

      if (form.ok) {
        LzToast.overlay('Logging in...');
        ResHandler res = await authApi.login(form.value);
        
        // ignore: avoid_print
        print('${res.request?.log}');

        if (!res.status) {
          LzToast.show(res.message);
          return false;
        }

        String? token = res.body['token'];

        if (token != null) {
          // set token to dio
          dio.setToken(token);

          // save token to shared preferences
          prefs.setString('token', token);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    } finally {
      LzToast.dismiss();
    }

    return true;
  }

  // this method is used to logout from the app
  // return true if logout is success

  Future<bool> logout() async {
    // assume that logout is success
    return true;
  }
}

final authProvider = ChangeNotifierProvider((ref) => Auth());
