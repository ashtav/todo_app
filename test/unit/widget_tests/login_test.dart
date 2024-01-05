import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/screens/login/views/login_view.dart';

void main() {
  testWidgets('Login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        home: LoginView(),
      ),
    ));
    await tester.pump();

    // find LzButton with text "Login"
    final loginButton = find.text('Login');
    expect(loginButton, findsOneWidget);

    // tap the login button
    await tester.tap(loginButton);
    await tester.pump();
    
  });
}
