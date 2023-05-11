import 'package:flutter/cupertino.dart';

class AppTitle extends StatelessWidget {
  final String title;

  const AppTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 50,
          bottom: 20,
        ),
        child: Text(title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)));
  }
}
