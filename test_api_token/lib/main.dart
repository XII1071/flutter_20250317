import 'package:test_api_token/provider/schedule_provider.dart';
import 'package:test_api_token/repository/auth_repository.dart';
import 'package:test_api_token/repository/schedule_repository.dart';
import 'package:test_api_token/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // UI 렌더링을 효율적으로 하기 위한 코드
  WidgetsFlutterBinding.ensureInitialized();

  // 국가별 날짜를 사용하기 전 무조건 한번은 실행
  await initializeDateFormatting('ko_KR');

  // Repository: 네트워크를 통해서 데이터 접근하여 데이타를 가져오는 객체
  final scheduleRepository = ScheduleRepository(); // 데이터베이스 접근 위한 객체 생성
  final authRepository = AuthRepository();

  // Provider: Repository를 통해 가져온 데이터를 신속하게 화면에 갱신하는 객체
  final scheduleProvider = ScheduleProvider(
    scheduleRepository: scheduleRepository,
    authRepository: authRepository,
  ); // cache를 이용한 성능 향상 객체

  runApp(
    // Provider 패키지에서 제공하는 상태 관리용 위젯, 하위에 있는 모든 위젯들이 scheduleProvider를 사용하게 함.
    // notifyListeners() 호출된 곳에서 화면을 갱신하기 위해 선언됨.
    ChangeNotifierProvider(
      create: (_) => scheduleProvider,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthScreen()
      ),
    ),
  );
}
