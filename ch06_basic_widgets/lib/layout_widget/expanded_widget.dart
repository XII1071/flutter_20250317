import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.blue)),
              // Expanded flex 기본 값이 1
              Expanded(child: Container(color: Colors.red)),
              Expanded(child: Container(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
