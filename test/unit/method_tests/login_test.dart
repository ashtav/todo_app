import 'package:fetchly/fetchly.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/app/data/api/api.dart';

import 'login_test.mocks.dart';

/*

Unit Testing adalah proses di mana komponen individual dari sebuah perangkat lunak diuji untuk memverifikasi 
bahwa setiap unit bekerja sesuai dengan desainnya. 
Pengujian unit dilakukan oleh pengembang untuk memastikan bahwa kode yang mereka tulis bekerja dengan benar 
sebelum kode tersebut diintegrasikan dengan komponen lain. 

Kunci dari pengujian unit adalah isolasi: setiap unit diuji secara terpisah dari yang lain untuk menghilangkan 
ketergantungan dan memastikan bahwa hasil pengujian hanya berfokus pada unit tersebut.

Keuntungan dari pengujian unit termasuk deteksi bug yang lebih cepat, peningkatan kualitas kode, 
dan memudahkan proses refactoring. Namun, pengujian unit juga memiliki keterbatasan, seperti tidak dapat 
menangkap masalah integrasi atau isu yang muncul hanya ketika komponen dikombinasikan, 
yang memerlukan pengujian lebih lanjut di tingkat integrasi atau sistem.

Cara pengujian :

1.  Siapkan unit yang akan diuji, dalam hal ini adalah fungsi login dari AuthApi
2.  Buat mock object untuk menggantikan fungsi login dari AuthApi
    - di atas void main() tambahkan anotasi @GenerateMocks([AuthApi])
    - lalu jalankan perintah flutter pub run build_runner build, ini akan men-generate file unit_test.mocks.dart
    - import file unit_test.mocks.dart
3.  Sesuaikan kode pengujian dan jalankan test

*/

// Object mock manual tanpa menggunakan anotasi @GenerateMocks
// class MockAuthApi extends Mock implements AuthApi {
//   @override
//   Future<ResHandler> login(Map<String, dynamic>? data) async {
//     return Future.value(ResHandler(status: true));
//   }
// }

@GenerateMocks([AuthApi])
void main() {
  late MockAuthApi mockAuth;

  setUp(() {
    mockAuth = MockAuthApi();
  });

  tearDown(() {});

  group('AuthApi Tests', () {
    test('Successful login', () async {
      // Arrange
      // Menyipakan mock response object yang akan dikembalikan oleh mockAuth.login
      // Bagian ini tidak digunakan (comment), jika menggunakan object mock manual
      var mockResponse = ResHandler(status: true);
      when(mockAuth.login(any)).thenAnswer((_) async => mockResponse);

      // Act
      // Panggil fungsi login dari mockAuth
      var result = await mockAuth.login({'email': 'test@example.com', 'password': 'password'});

      // Assert
      // Pastikan bahwa result yang dikembalikan oleh fungsi login adalah ResHandler
      expect(result, isInstanceOf<ResHandler>());
      expect(result.status, isTrue);
    });

    test('Failed login', () async {
      // Arrange
      var mockError = ResHandler(status: false); // Create a mock error response object as needed
      when(mockAuth.login(any)).thenAnswer((_) async => mockError);

      // Act
      var result = await mockAuth.login({'email': 'wrong@example.com', 'password': 'wrongpass'});

      // Assert
      expect(result, isInstanceOf<ResHandler>()); // Even in failure, it should return a ResHandler
      expect(result.status, isFalse);
    });
  });
}
