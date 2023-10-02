part of api;

class AuthApi {
  Future<Response> login(Map<String, dynamic> data) async {
    return await dio.post('auth/login', data: data);
  }
}
