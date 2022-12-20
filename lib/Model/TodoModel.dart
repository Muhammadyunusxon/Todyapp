class TodoModel {
  String title;
  bool isDone;

  TodoModel({required this.title, this.isDone =false});

  factory TodoModel.fromJson(Map data) {
    return TodoModel(title: data['title'], isDone: data['is_done']);
  }

  Map toJson() => {'title': title, 'is_done': isDone};
}
