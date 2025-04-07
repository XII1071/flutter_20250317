import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexibleExpandedMixedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Flexible(flex: 2, child: Container(color: Colors.blue)),
              // Flexible(flex: 1, child: Container(color: Colors.red)),
              Expanded(child: Container(color: Colors.green)), // 남는 공간을 모두 차지
              Container(
                height: 100,
                color: Colors.pink,
                child: Center(child: Text("Container")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
