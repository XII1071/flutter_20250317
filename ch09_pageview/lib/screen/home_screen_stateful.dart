import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenStateful extends StatefulWidget {
  const HomeScreenStateful({Key? key}) : super(key: key);

  @override
  State<HomeScreenStateful> createState() => _HomeScreenStateful();
}

class _HomeScreenStateful extends State<HomeScreenStateful> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) => print('실행!'));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 배경 투명
        statusBarIconBrightness: Brightness.dark, // 글자 색 dark, light
      ),
    );
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // 상태바/내비게이션바는 투명하게 유지, 내용은 그 아래까지 확장
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // 완전히 숨김, 화면 스와이프로만 다시 나타남
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); // 일시적으로 숨김, 화면 터치 시 다시 나타남
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
    ); // 직접 오버레이 항목 설정 (overlays 사용)
    return Scaffold(
      body: PageView(
        children:
        [1, 2, 3, 4, 5]
            .map(
              (num) => Image.asset(
            'asset/img/image_$num.jpeg',
            fit: BoxFit.cover,
          ),
        )
            .toList(),
      ),
    );
  }
}