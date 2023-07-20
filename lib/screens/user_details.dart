import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/screens/user_todo_data.dart';

class UserDetails extends StatelessWidget {
  final String userName;
  final String age;
  final String birthDate;

  const UserDetails(
      {super.key,
      required this.userName,
      required this.age,
      required this.birthDate});

  @override
  Widget build(BuildContext context) {
    void _pushToUserTodoData() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UserTodoData();
      }));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: tdBlue,
        title: Text('Detalhes do usuário'),
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
              Text(
                userName,
                style: const TextStyle(
                    color: tdBlack, fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                birthDate,
                style: const TextStyle(
                    color: tdBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              Text(
                age + ' anos',
                style: const TextStyle(
                    color: tdBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: Text(
                    'Ver dados de tarefas',
                  ),
                  onPressed: _pushToUserTodoData,
                  style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10))
            ],
          )
        ],
      )),
    );
  }
}
