import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';

class NewToDoInput extends StatefulWidget {
  final onClickInputButton;

  NewToDoInput({super.key, required this.onClickInputButton});

  @override
  State<NewToDoInput> createState() => _NewToDoInputState();
}

class _NewToDoInputState extends State<NewToDoInput> {
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset((0.0), 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Adicione uma nova tarefa',
                        border: InputBorder.none)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      if (_todoController.text.isNotEmpty) {
                        widget.onClickInputButton(_todoController.text);
                        _todoController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10))),
          ],
        ));
  }
}
