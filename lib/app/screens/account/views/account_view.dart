import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/routes/paths.dart';

import '../../../data/services/local/storage.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: Maa.center,
        children: [
          Icon(
            Ti.user,
            size: 50,
            color: LzColors.black,
          ),
          Textr(
            'Account View',
            style: Gfont.fs18.bold,
            margin: Ei.only(b: 10, t: 25),
          ),
          Textr(Faker.words(15), textAlign: Ta.center, margin: Ei.only(b: 25)),
          LzButton(
              text: 'Logout',
              icon: Ti.arrowLeft,
              onTap: (state) {
                state.submit();

                Utils.timer(() {
                  prefs.remove('token');
                  context.go(Paths.login);

                  state.abort();
                }, 1.s);
              })
        ],
      ).padding(all: 20),
    ));
  }
}
