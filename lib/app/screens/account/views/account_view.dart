import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/core/constants/font.dart';
import 'package:todo_app/app/routes/paths.dart';

import '../../../data/services/local/storage.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            TablerIcons.user,
            size: 50,
            color: Colors.black,
          ),
          Text(
            'Account View',
            style: Gfont.fs18.bold,
          ),
          ElevatedButton(
            onPressed: () {
              prefs.remove('token');
              context.go(Paths.login);
            },
            child: const Text('Logout'),
          )
        ],
      ),
    ));
  }
}
