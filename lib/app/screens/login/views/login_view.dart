import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/providers/login/login_provider.dart';
import 'package:todo_app/app/routes/paths.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authProvider.notifier);
    final forms = notifier.forms;

    // di sini kita menggunakan design dari LazyUI untuk membuat form
    // tentu kamu bisa menggunakan cara dan design yang kamu inginkan
    // LazyUI hanya mempermudah dan mempercepat proses pembuatan UI

    // supaya kita tidak perlu mengisi form,
    // kita set saja value defaultnya .fill()
    forms.fill({'email': 'admin@gmail.com', 'password': 'secret'});

    return Wrapper(
      child: Scaffold(
          body: Center(
        child: SizedBox(
          width: 320,
          child: LzListView(
            padding: Ei.sym(v: 50),
            scrollLimit: const [50, 50],
            shrinkWrap: true,
            children: [
              // form title
              Column(
                children: [
                  Textr('Please login to continue', style: Gfont.fs18.bold, margin: Ei.only(b: 5)),
                  Text(Faker.words(10), textAlign: Ta.center, style: Gfont.muted),
                ],
              ).margin(b: 25),

              // form input
              LzFormGroup(
                children: [
                  LzForm.input(hint: 'Enter your email', model: forms['email']),
                  LzForm.input(hint: 'Enter your password', obsecureToggle: true, model: forms['password']),
                ],
              ),

              // form button
              LzButton(
                text: 'Login',
                onTap: (state) async {
                  // kamu juga bisa menggunakan -> state.submit();
                  // untuk menampilkan animasi loading pada button
                  // lalu state.abort(); untuk menghentikan animasi loading

                  final ok = await notifier.login();

                  if (ok && context.mounted) {
                    context.go(Paths.home);
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
