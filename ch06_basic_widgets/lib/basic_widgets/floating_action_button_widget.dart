import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("스낵바가 올라왔습니다."),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.redAccent,
              ),
            );
          },
          child: Text('클릭'),
        ),
        body: Container(),
      ),
    );
  }
}
