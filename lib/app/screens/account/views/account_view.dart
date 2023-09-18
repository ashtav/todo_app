import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

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
          Text(Faker.words(15), textAlign: Ta.center),
        ],
      ).padding(all: 20),
    ));
  }
}
