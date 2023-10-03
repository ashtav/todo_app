import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:todo_app/app/core/constants/font.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(35),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            TablerIcons.message_2,
            size: 50,
            color: Colors.black87,
          ),
          const SizedBox(height: 25),
          Text(
            'Support View',
            style: Gfont.fs18.bold,
          ),
          const SizedBox(height: 5),
          Text(
            'Lorem ipsum dolor sit amet consectetur adipiscing elit magna aliqua.',
            style: Gfont.muted,
            textAlign: TextAlign.center,
          ),
        ],
      )),
    ));
  }
}
