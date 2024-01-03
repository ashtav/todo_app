import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/data/api/api.dart';
import 'package:todo_app/app/providers/login/login_provider.dart';

class MockApi extends Mock implements AuthApi {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockDio extends Mock implements Dio {}

void main() {
  group('Auth Tests', () {
    late MockApi mockApi;
    late MockSharedPreferences mockSharedPreferences;
    late MockDio mockDio;
    late Auth auth;

    final payload = {'email': 'admin@gmail.com', 'password': 'secret'};

    setUp(() {
      mockApi = MockApi();
      mockSharedPreferences = MockSharedPreferences();
      mockDio = MockDio();
      auth = Auth(); // Assuming your Auth class can accept mocked dependencies

      // Set up mock dependencies
      when(mockApi.login(payload))
          .thenAnswer((_) async => ResHandler(status: true, body: {'token': 'dummy_token'}));
    });

    testWidgets('Successful login test', (WidgetTester tester) async {
      // Membuat context sederhana menggunakan Builder
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  auth.login(); // Memanggil login dengan context yang dibuat
                },
                child: const Text('Login'),
              );
            },
          ),
        ),
      );

      // Meniru interaksi pengguna
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verifikasi hasil setelah login
      expect(find.text('Logging in...'), findsOneWidget);
      
    });
  });

  test('Logout testing', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final auth = container.read(authProvider.notifier);
    expect(await auth.logout(), true);
  });
}
