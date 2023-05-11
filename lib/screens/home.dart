import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/app_title.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/widgets/search_box.dart';
import 'package:todo/widgets/new_todo_input.dart';
import 'package:todo/screens/user_details.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList(); // Mocks de afazeres
  List<ToDo> _filteredToDo = []; // Variável responsável pelos dados filtrados

  // Modifica a propriedade isDone do componente TodoItem
  void _handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  // Remove um afazer da lista todoList e da lista de todos filtrados
  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
      _filteredToDo.removeWhere((item) => item.id == id);
    });
  }

  // Adiciona um novo todo
  void _addToDoItem(String toDoText) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDoText));
    });
  }

  // Filtra o array todoList e insere em _filteredTodo
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredToDo = results;
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
    _filteredToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
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
                  for (ToDo toDo in _filteredToDo.reversed)
                    ToDoItem(
                      todo: toDo,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,
                    ),
                  const SizedBox(height: 60)
                ])),
              ]),
            ),
            NewToDoInput(onClickInputButton: _addToDoItem)
          ],
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
