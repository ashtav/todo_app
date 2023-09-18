part of api;

class TodoApi extends Fetchly {
  Future<ResHandler> getTodos({int limit = 15}) async =>
      await get('todo', query: {'limit': limit});
}
