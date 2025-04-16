import 'package:ch19_scheduler_api/database/drift_database.dart';
import 'package:ch19_scheduler_api/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // UI 렌더링을 효율적으로 하기 위한 코드
  WidgetsFlutterBinding.ensureInitialized();

  // 국가별 날짜를 사용하기 전 무조건 한번은 실행
  await initializeDateFormatting('ko_KR');

  final database = LocalDatabase(); // 데이터베이스 생성

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}