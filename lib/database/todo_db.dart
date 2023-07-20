import 'package:sqflite/sqflite.dart';
import 'package:todo/database/database_service.dart';
import 'package:todo/model/todo.dart';

class TodoDB {
  final tableName = 'todos';

  Future<void> createTable(Database database) async {
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $tableName ("id" INTEGER NOT NULL,  "userId" TEXT NOT NULL, "title" TEXT NOT NULL, "completed" INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT));""");
  }

  Future<int> create(ToDo newTodo) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, newTodo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(ToDo todoToUpdate) async {
    final database = await DatabaseService().database;
    return await database.update(tableName, todoToUpdate.toJson(),
        where: 'id = ?', whereArgs: [todoToUpdate.id]);
  }

  Future<ToDo?> getLastToDoCreated() async {
    final database = await DatabaseService().database;
    final List<Map<String, dynamic>> toDos = await database.rawQuery(
      'SELECT * FROM $tableName ORDER BY id DESC LIMIT 1',
    );

    if (toDos.isNotEmpty) {
      return ToDo.fromJson(toDos.first);
    }

    return null;
  }
}
