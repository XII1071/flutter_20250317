import 'package:ch19_scheduler_api/database/drift_database.dart';
import 'package:ch19_scheduler_api/provider/schedule_provider.dart';
import 'package:ch19_scheduler_api/repository/schedule_repository.dart';
import 'package:ch19_scheduler_api/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // UI 렌더링을 효율적으로 하기 위한 코드
  WidgetsFlutterBinding.ensureInitialized();

  // 국가별 날짜를 사용하기 전 무조건 한번은 실행
  await initializeDateFormatting('ko_KR');

  final database = LocalDatabase(); // 데이터베이스 생성
  final repository = ScheduleRepository(); // 데이터베이스 접근 위한 객체 생성
  final scheduleProvider = ScheduleProvider(repository: repository); // cache를 이용한 성능 향상 객체

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    // Provider 패키지에서 제공하는 상태 관리용 위젯, 하위에 있는 모든 위젯들이 scheduleProvider를 사용하게 함.
    ChangeNotifierProvider(
      create: (_) => scheduleProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
