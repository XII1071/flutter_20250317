import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soul_talk/model/message_model.dart';
import 'package:soul_talk/screen/home_screen.dart';

void main() async {
  // WidgetsFlutterBinding이 초기화되어 애플리케이션에서 UI 렌더링이 가능하게 함.
  WidgetsFlutterBinding.ensureInitialized();

  // 앱만의 저장 공간이며, 앱의 크기와 관련, 파일 저장에 관련된 기능을 구현한 클래스
  final dir = await getApplicationDocumentsDirectory();

  // Isar 인스턴스에서 사용하고 싶은 모든 스키마를 지정: Isar는 flutter에서 사용가능한 고성능 NoSQL
  final isar = await Isar.open(
    [MessageModelSchema],
    directory: dir.path,
  );

  // Dart 언어에서 의존성 주입을 위해 사용하는 도구
  // registerSingleton: 단 한 개의 instance를 생성하여 반환
  // GetIt은 의존성 주입 도구로, Isar 인스턴스를 어디서든 쉽게 사용
  GetIt.I.registerSingleton<Isar>(isar);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
