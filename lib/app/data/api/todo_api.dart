part of api;

class TodoApi {
  Future<Response> getTodos({int limit = 15}) async => await dio.get('todos', queryParameters: {'limit': limit});

  Future<Response> getTodoDetail(int id) async => await dio.get('todos/$id');

  Future<Response> createTodo(Map<String, dynamic> data) async => await dio.post('todo', data: data);
}
