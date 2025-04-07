import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeAreaWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          top: false,
          bottom: true,
          left: true,
          right: true,
          child: Container(color: Colors.red, height: 300.0, width: 300.0),
        ),
      ),
    );
  }
}
