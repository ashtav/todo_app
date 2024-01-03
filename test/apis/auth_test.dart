// Mengimpor paket-paket yang diperlukan
import 'dart:convert'; // Mengimpor pustaka jsonEncode

import 'package:fetchly/fetchly.dart';
import 'package:flutter_test/flutter_test.dart'; // Mengimpor pustaka untuk unit testing di Flutter
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_app/app/data/api/api.dart'; // Mengimpor pustaka http_mock_adapter untuk mocking HTTP requests

/*

Dalam kode ini, kita melakukan pengujian menggunakan teknik mocking atau pemalsuan.
Dalam konteks ini, mocking digunakan untuk menggantikan permintaan HTTP yang sebenarnya ke server eksternal dengan respons palsu. 
Ini memungkinkan kita untuk menguji bagaimana aplikasi akan merespons permintaan ke server 
tanpa benar-benar melakukan koneksi yang sesungguhnya ke server eksternal.

*/

class MockFetchly extends Fetchly {
  @override
  Future<ResHandler> post(String path, dynamic data, {bool useFormData = false}) async {
    // Mengembalikan mock response untuk permintaan POST
    if (path == 'auth/login') {
      return ResHandler(status: true, data: {'user_id': 123}); // Contoh respons
    }
    return super.post(path, data, useFormData: useFormData);
  }
}

void main() async {
  // Memulai grup pengujian untuk penggunaan DioAdapter
  group('Todo Data Interaction', () {
    // Menentukan alamat URL yang akan digunakan dalam pengujian
    const path = 'https://jsonplaceholder.typicode.com/todos/1';

    // Mengawasi pengujian yang memeriksa apakah DioAdapter mampu melakukan mocking data
    test('Get Specific Todo Data', () async {
      final dio = Dio(); // Membuat instance Dio untuk digunakan dalam mocking HTTP requests
      final dioAdapter = DioAdapter(dio: dio); // Membuat instance DioAdapter untuk Dio

      dio.httpClientAdapter = dioAdapter; // Mengkonfigurasi Dio untuk menggunakan DioAdapter

      // Mendefinisikan rute untuk permintaan GET ke alamat URL tertentu
      dioAdapter.onGet(path, (request) {
        request.reply(200, {
          // Mengembalikan respons dengan status 200 dan data JSON
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        });
      });

      // Melakukan permintaan GET menggunakan Dio ke alamat URL yang telah didefinisikan
      final getResponse = await dio.get(path);

      // Mendefinisikan respons yang diharapkan dalam bentuk objek JSON
      final expectedResponse = {"userId": 1, "id": 1, "title": "delectus aut autem", "completed": false};

      // Memeriksa apakah respons yang diterima sesuai dengan respons yang diharapkan
      expect(jsonEncode(expectedResponse), jsonEncode(getResponse.data));
    });
  });

  test('login returns response data', () async {
    final mockDio = Dio(); // Membuat instance Dio untuk digunakan dalam mocking HTTP requests
    final dioAdapter =
        DioAdapter(dio: mockDio, matcher: const UrlRequestMatcher()); // Membuat instance DioAdapter untuk Dio

    final dioApi = DioApi(mockDio); // Membuat instance DioApi dengan menggunakan mockDio

    final testData = {'username': 'test', 'password': 'test123'};
    final expectedResponseData = {'user_id': 123};

    mockDio.httpClientAdapter = dioAdapter; // Mengkonfigurasi Dio untuk menggunakan DioAdapter

    // Mendefinisikan rute untuk permintaan POST ke alamat URL tertentu
    dioAdapter.onPost('auth/login', (request) {
      request.reply(200, expectedResponseData); // Mengembalikan respons dengan status 200 dan data JSON
    });

    // Melakukan pemanggilan ke fungsi login dengan data tes
    final result = await dioApi.login(testData);

    // // Memeriksa apakah hasil pemanggilan sesuai dengan respons yang diharapkan
    expect(jsonEncode(result), jsonEncode(expectedResponseData));
  });
}
