class Todo {
  static const _columnId = "id";
  static const _columnTitle = "title";
  static const _columnDescription = "description";

  int id;
  String title;
  String description;

  Todo({required this.id, required this.title, required this.description});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json[_columnId],
      title: json[_columnTitle],
      description: json[_columnDescription],
    );
  }
}
