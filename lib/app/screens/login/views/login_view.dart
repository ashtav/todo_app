import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/providers/login/login_provider.dart';

import '../../../core/constants/font.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authProvider.notifier);
    final email = notifier.email, password = notifier.password;

    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 320,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          shrinkWrap: true,
          children: [
            // form title
            Column(
              children: [
                Text('Please login to continue', style: Gfont.fs18.bold),
                Text('Lorem ipsum dolor sit amet consectetur adipiscing elit.',
                    textAlign: TextAlign.center, style: Gfont.muted),
              ],
            ),

            // form input
            TextField(controller: email),
            TextField(controller: password),

            // form button
            ElevatedButton(
              onPressed: () {
                notifier.login(context);
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    ));
  }
}
