import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_DDay(), _CoupleImage()],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(children: [
      const SizedBox(height: 16.0),
      Text(
        // 최상단 U&I 글자
        'U&I',
        style: textTheme.displayLarge,
      ),
      const SizedBox(height: 16.0),
      Text(
        // 두번째 글자
        '우리 처음 만난 날',
        style: textTheme.bodyLarge,
      ),
      Text(
        // 임시로 지정한 만난 날짜
        // '${firstDay.year}.${firstDay.month}.${firstDay.day}',
        '',style: textTheme.bodyMedium,
      ),
      const SizedBox(height: 16.0),
      IconButton(
        // 하트 아이콘 버튼
        iconSize: 60.0,
        onPressed: (){},
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      const SizedBox(height: 16.0),
      Text(
        // 만난 후 DDay
        //'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
        '',style: textTheme.displayMedium,
      ),
    ]);
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'asset/img/middle_image.png',
        // MediaQuery.of(context)는 MaterialApp에서 빌드될 때 생성된 MediaQuery를 가리킴
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }
}