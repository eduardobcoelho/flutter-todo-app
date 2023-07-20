import 'dart:convert';
import 'package:todo/model/todo.dart';
import 'package:http/http.dart' as http;

const apiBaseUrl = 'https://jsonplaceholder.typicode.com';

class RemoteService {
  Future<List<ToDo>?> getTodosJsonPlaceholder() async {
    var client = http.Client();
    var uri = Uri.parse(apiBaseUrl + '/todos');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return toDoJsonPlaceholderFromJson(json);
    }
  }

  Future<ToDo?> getTodo(String toDoId) async {
    var client = http.Client();
    var uri = Uri.parse(apiBaseUrl + '/todos/' + toDoId);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
