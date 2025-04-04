import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              // Fluttertoast.showToast(
              //   msg: "버튼이 클릭되었습니다",
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 1,
              // );
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("스낵바가 올라왔습니다."),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.amber),
            child: Text('텍스트 버튼'),
          ),
        ),
      ),
    );
  }
}