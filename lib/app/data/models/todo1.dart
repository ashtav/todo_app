class Todo1 {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Todo1({this.userId, this.id, this.title, this.completed});

  factory Todo1.fromJson(Map<String, dynamic> json) => Todo1(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        completed: json['completed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'completed': completed,
      };
}
