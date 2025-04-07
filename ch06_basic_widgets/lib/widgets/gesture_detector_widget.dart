import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureDetectorWidgetExample extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){print("클릭");},
            onDoubleTap: (){print("더블 클릭");},
            onLongPress: (){print("롱 클릭");},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              width: 100.0,
              height: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}