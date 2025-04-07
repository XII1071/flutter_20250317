import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Hello Flutter",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
