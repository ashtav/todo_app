import 'package:flutter/material.dart';

class AppLockView extends StatelessWidget {
  const AppLockView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This app is locked for now, please try again later.'),
      ),
    );
  }
}
