part of api;

class TodoApi {
  Future<Response> getTodos({int limit = 15}) async => await dio.get('todo', queryParameters: {'limit': limit});
  Future<Response> createTodo(Map<String, dynamic> data) async => await dio.post('todo', data: data);
}
