import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/services/local/storage.dart';
import '../../routes/paths.dart';

class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['email', 'password']);

  Future login(BuildContext context) async {
    try {
      final form = LzForm.validate(forms, required: ['*']);

      if (form.ok) {
        LzToast.overlay('Logging in...');
        ResHandler res = await authApi.login(form.value);

        if (!res.status) {
          return LzToast.show(res.message);
        }

        String? token = res.body['token'];

        if (token != null) {
          if (!context.mounted) return;

          prefs.setString('token', token);
          context.go(Paths.home);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => Auth());
