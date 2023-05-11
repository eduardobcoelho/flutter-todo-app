import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/screens/home.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
      backgroundColor: Colors.white,
    );

    void _pushToHome() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }

    return Scaffold(
      backgroundColor: tdBlue,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Olá :)',
                style: TextStyle(
                    color: tdBGColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text(
                'Boas vindas!',
                style: TextStyle(
                    color: tdBGColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: buttonStyle,
                  onPressed: _pushToHome,
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                        color: tdBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          )
        ],
      )),
    );
  }
}
