import 'package:flutter/material.dart';

class ElevatedButtonWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("스낵바가 올라왔습니다."),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.amber,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),  // 라운드 처리
              )
            ),
            child: Text('엘레베이티드 버튼'),
          ),
        ),
      ),
    );
  }
}

extension on RoundedRectangleBorder {
  toButtonStyle() {}
}
