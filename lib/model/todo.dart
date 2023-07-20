import 'dart:convert';

List<ToDo> toDoJsonPlaceholderFromJson(String str) =>
    List<ToDo>.from(json.decode(str).map((x) => ToDo.fromJson(x)));

String postToJson(List<ToDo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDo {
  ToDo(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed});

  int id;
  int userId;
  String title;
  bool completed;

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "userId": userId, "title": title, "completed": completed};
}
