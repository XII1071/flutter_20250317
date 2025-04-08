import 'package:ch08_blog/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // 플러터 프레임워크가 앱을 실행할 준비가 됐는지 확인 역할, 없어도 실행 됨.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web View Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
