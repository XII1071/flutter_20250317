import 'package:flutter/material.dart';

class Mylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인 화면")),
      body: Center(
        child: Text(
          "환영합니다!",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}