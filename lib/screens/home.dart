import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/services/remote_service.dart';
import 'package:todo/widgets/app_title.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/widgets/search_box.dart';
import 'package:todo/widgets/new_todo_input.dart';
import 'package:todo/screens/user_details.dart';
import 'package:todo/database/todo_db.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentPagination = 10;
  var isLoaded = false;
  List<ToDo> _filteredToDo = []; // Variável responsável pelos dados filtrados
  List<ToDo> _todosJsonPlaceholder = [];

  _increaseCurrentPagination() {
    currentPagination += 5;
    _runFilter('');
  }

  // Modifica a propriedade isDone do componente TodoItem
  void _handleToDoChange(ToDo toDo) async {
    await TodoDB().update(toDo);
    setState(() {
      toDo.completed = !toDo.completed;
    });
  }

  // Remove um afazer da lista todoList e da lista de todos filtrados
  void _deleteToDoItem(int id) {
    setState(() {
      _todosJsonPlaceholder.removeWhere((item) => item.id == id);
      _filteredToDo.removeWhere((item) => item.id == id);
    });
  }

  // Adiciona um novo todo
  void _addToDoItem(String toDoText) async {
    ToDo newTodo = ToDo(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: 1,
        title: toDoText,
        completed: false);

    await TodoDB().create(newTodo);

    setState(() {
      _todosJsonPlaceholder.insert(0, newTodo);
    });

    _runFilter('');
  }

  // Filtra o array todoList e insere em _filteredTodo
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = _todosJsonPlaceholder;
    } else {
      results = _todosJsonPlaceholder
          .where((item) =>
              item.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredToDo = results.take(currentPagination).toList();
    });
  }

  // Joga o usuário para a página de detalhes do usuário
  void _pushToUserDetails() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const UserDetails(
          userName: 'Luiz Eduardo', age: '21', birthDate: '26/06/2001');
    }));
  }

  @override
  void initState() {
    super.initState();

    // COMECA AQUI
    getTodosJsonPlaceholder();
  }

  getTodosJsonPlaceholder() async {
    var result = await RemoteService().getTodosJsonPlaceholder();
    if (result != null) {
      setState(() {
        _filteredToDo = result.take(currentPagination).toList();
        _todosJsonPlaceholder = result;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Visibility(
          visible: isLoaded,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(children: [
                  // Componente para filtrar pelo texto do todo
                  SearchBox(onChanged: _runFilter),
                  Expanded(
                      child: ListView(children: [
                    // Componente do título da página
                    const AppTitle(title: 'Lista de tarefas'),
                    // Iteração em todos os todos
                    for (ToDo toDo in _filteredToDo)
                      ToDoItem(
                        todo: toDo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                    TextButton(
                        onPressed: _increaseCurrentPagination,
                        child: const Text('Ver mais')),
                    const SizedBox(height: 80)
                  ])),
                ]),
              ),
              NewToDoInput(onClickInputButton: _addToDoItem)
            ],
          ),
          replacement: const Center(
              child: CircularProgressIndicator(
            color: tdBlue,
          )),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _pushToUserDetails,
              iconSize: 24,
              icon: const Icon(Icons.remove_red_eye, color: tdBlue),
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  child: Image.asset('assets/images/avatar.png'),
                  borderRadius: BorderRadius.circular(20)),
            )
          ],
        ));
  }
}
