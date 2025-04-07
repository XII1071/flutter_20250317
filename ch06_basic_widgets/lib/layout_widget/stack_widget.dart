import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // child: Stack(
          //   children: [
          //     Container(height: 300.0, width: 300.0, color: Colors.red),
          //     Container(height: 250.0, width: 250.0, color: Colors.yellow),
          //     Container(height: 200.0, width: 200.0, color: Colors.blue),
          //   ], // z-index 같은 속성은 없다.
          // ),
          child: IndexedStack(
            // IndexedStack은 Stack과 달리 하나만 표시
            index: 1,
            children: [
              Container(height: 300.0, width: 300.0, color: Colors.red),
              Container(height: 250.0, width: 250.0, color: Colors.yellow),
              Container(height: 200.0, width: 200.0, color: Colors.blue),
            ], // z-index 같은 속성은 없다.
          ),
        ),
      ),
    );
  }
}
