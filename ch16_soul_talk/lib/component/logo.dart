import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;

  const Logo({
    super.key,
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          // 로고 이미지
          'asset/img/logo.png',
          width: width,
          height: height,
        ),
        const SizedBox(height: 32.0),
        const Text(
          // 앱 설명 텍스트
          '안녕! 반가워!\n너와의 대화를 기대혀~!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
