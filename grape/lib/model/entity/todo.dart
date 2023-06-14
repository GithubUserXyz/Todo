import 'entity.dart';

const _columnId = "id";
const _columnTitle = "title";
const _columnDescription = "description";

class Todo implements Entity {
  int id;
  String title;
  String description;

  Todo({required this.id, required this.title, required this.description});

  @override
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json[_columnId],
      title: json[_columnTitle],
      description: json[_columnDescription],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[_columnId] = id;
    data[_columnTitle] = title;
    data[_columnDescription] = description;
    return data;
  }
}
