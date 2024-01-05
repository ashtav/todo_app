// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Successful login test', (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // final auth = container.read(authProvider.notifier);

    // Membuat context sederhana menggunakan Builder
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                // auth.login2(context); // Memanggil login dengan context yang dibuat
              },
              child: const Text('Login'),
            );
          },
        ),
      ),
    );

    // Meniru interaksi pengguna
    // await tester.tap(find.text('Login'));
    // await tester.pump();

    // Verifikasi hasil setelah login
    // expect(find.text('Logging in...'), findsOneWidget);
  });
}
