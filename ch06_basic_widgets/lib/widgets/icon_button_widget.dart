import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("스낵바가 올라왔습니다."),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.redAccent,
              ),
            );
          }, icon: Icon(Icons.home)),
        ),
      ),
    );
  }
}