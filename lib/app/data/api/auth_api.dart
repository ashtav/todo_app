part of api;

class AuthApi extends Fetchly {
  Future<ResHandler> login(Map<String, dynamic> data) async => await post('auth/login', data);
}

class DioApi {
  final Dio dio;
  DioApi(this.dio);

  Future login(Map<String, dynamic> data) async {
    final response = await dio.post('auth/login', data: data);
    return response.data;
  }
}
