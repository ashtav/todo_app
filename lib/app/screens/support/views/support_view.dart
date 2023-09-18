import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: Maa.center,
        children: [
          Icon(
            Ti.message2,
            size: 50,
            color: LzColors.black,
          ),
          Textr(
            'Support View',
            style: Gfont.fs18.bold,
            margin: Ei.only(b: 10, t: 25),
          ),
          Text(Faker.words(15), textAlign: Ta.center),
        ],
      ).padding(all: 20),
    ));
  }
}
