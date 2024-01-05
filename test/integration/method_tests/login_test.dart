import 'package:fetchly/fetchly.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/data/api/api.dart';
import 'package:todo_app/app/providers/login/login_provider.dart';

/*

Integration test adalah jenis pengujian yang bertujuan untuk memverifikasi bahwa 
berbagai bagian dari sistem bekerja bersama dengan baik.

Integration testing memiliki kekurangan seperti keterbatasan dalam menciptakan skenario pengujian 
yang beragam dan spesifik, yang sering diperlukan untuk mengevaluasi semua aspek fungsionalitas sistem. 
Hal ini disebabkan oleh fokus pengujian pada interaksi antar komponen daripada detail fungsionalitas individual.

*/

void main() {
  test('Login testing', () async {
    final auth = AuthApi();
    final payload = {'email': 'admin@gmail.com', 'password': 'secret'};

    final res = await auth.login(payload);
    expect(res, isA<ResHandler>());
    // expect(res.status, true);
    // expect(res.data, isA<Map<String, dynamic>>());
  });

  // Menguji fungsi login pada auth provider
  test('Login auth provider testing', () async {
    // Menginisialisasi Fetchly dengan baseURL
    Fetchly.init(baseUrl: 'https://dummyjson.com/');

    // Membuat container baru untuk provider, ini digunakan untuk mengisolasi state dan memudahkan pengujian.
    final container = ProviderContainer();

    // Menambahkan 'tearDown' untuk membersihkan container setelah test selesai, ini memastikan bahwa setiap test independen.
    addTearDown(container.dispose);

    // Membaca 'authProvider' dari container, ini adalah langkah untuk mengakses state dan logika bisnis dari authProvider.
    final auth = container.read(authProvider.notifier);

    // Mengisi form pada auth provider dengan username dan password, Ini mensimulasikan input pengguna.
    auth.forms.fill({'username': 'kminchelle', 'password': '0lelplR'});

    // Melakukan operasi login dan menunggu hasilnya, ini akan menjalankan logika login di auth provider.
    final res = await auth.login();

    // Mengharapkan bahwa hasil dari login adalah tipe boolean, ini adalah bagian dari validasi test case.
    expect(res, isA<bool>());
  });
}
