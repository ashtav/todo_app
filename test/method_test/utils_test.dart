import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app/core/helpers/utils.dart';

void main() {
  // here we try to make a ucwords function with TDD implementation
  test('ucwords mengubah huruf pertama setiap kata menjadi kapital', () {
    expect(Utils.ucwords('hello world'), 'Hello World');
  });

  group('User', () {
    test('get data', () {});

    test('create data', () {});
  });
}
