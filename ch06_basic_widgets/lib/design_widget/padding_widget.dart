import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaddingWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // child: Container(
          //   color: Colors.blue,
          //   child: Padding(
          //     padding: EdgeInsets.all(16.0),
          //     child: Container(color: Colors.red, width: 50.0, height: 50.0),
          //   ),
          // ),
          child: Container(
            color: Colors.black,
            child: Container(
              // margin은 Container의 속성
              margin: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(color: Colors.red, width: 50.0, height: 50.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
