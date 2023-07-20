import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/database/todo_db.dart';
import 'package:todo/model/todo.dart';

class UserTodoData extends StatefulWidget {
  const UserTodoData({Key? key}) : super(key: key);

  @override
  State<UserTodoData> createState() => _UserTodoDataState();
}

class _UserTodoDataState extends State<UserTodoData> {
  ToDo? _lastTodoCreated;

  void getLastTodoCreated() async {
    var lastCreated = await TodoDB().getLastToDoCreated();
    if (lastCreated != null)
      setState(() {
        _lastTodoCreated = ToDo(
            id: lastCreated.id,
            userId: lastCreated.userId,
            title: lastCreated.title,
            completed: !!lastCreated.completed);
      });
  }

  String getLastTodoCreatedTitle() {
    return _lastTodoCreated?.title ?? "Nenhum item criado";
  }

  @override
  void initState() {
    super.initState();

    // COMECA AQUI
    getLastTodoCreated();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: tdRed,
        title: const Text('Dados de tarefas'),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 90,
                width: 90,
                child: ClipRRect(
                    child: Image.asset('assets/images/avatar.png'),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ultima tarefa criada: ',
                style: TextStyle(
                    color: tdBlack, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                getLastTodoCreatedTitle(),
                style: const TextStyle(
                    color: tdBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ],
          )
        ],
      )),
    );
  }
}
