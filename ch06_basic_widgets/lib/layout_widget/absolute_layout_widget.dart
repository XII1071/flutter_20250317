import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbsoluteLayoutWidgetExample extends StatelessWidget {
  // 절대배치란 Stack과 Positioned 위젯을 사용하는 것
  // 화면 크기에 따라 요소가 밀리거나 깨질 수 있다.
  // 반응형 UI를 만들기 어렵다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.blueAccent,),
            Positioned(top: 50, left: 40, child: Text('Welcome Back!',
              style: TextStyle(fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,),)),
            Positioned(top: 100, left: 50, child: Text("ID")),
            Positioned(top: 100, left: 130, right: 100,height: 50.0 , child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            )),
            Positioned(top: 180, left: 50, child: Text("Password")),
            Positioned(top: 180, left: 130, right: 100,height: 50.0 , child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            )),
          ],
        ),
      ),
    );
  }
}
