import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: Maa.center,
        children: [
          Icon(
            Ti.home,
            size: 50,
            color: LzColors.black,
          ),
          Textr(
            'Home View',
            style: Gfont.fs18.bold,
            margin: Ei.only(b: 10, t: 25),
          ),
          Text(Faker.words(15), textAlign: Ta.center),
        ],
      ).padding(all: 20),
    ));
  }
}
