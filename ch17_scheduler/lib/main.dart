import 'package:ch17_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // WidgetsFlutterBinding이 초기화되어 애플리케이션에서 UI 렌더링이 가능하게 함.
  WidgetsFlutterBinding.ensureInitialized();

  // 날짜/시간 서식 지정 등 국제화 및 로컬라이제이션에 사용되는 intl 패키지에서 제공하는 메서드
  // 날짜 서식 지정 메서드를 호출하기 전에 적어도 하나의 Locale 에 대해 이 함수를 호출
  await initializeDateFormatting();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
