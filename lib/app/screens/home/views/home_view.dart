import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:todo_app/app/core/constants/font.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          TablerIcons.home,
          size: 50,
          color: Colors.black,
        ),
        Text(
          'Support View',
          style: Gfont.fs18.bold,
        ),
      ],
    )));
  }
}
