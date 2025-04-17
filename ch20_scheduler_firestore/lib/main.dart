import 'package:ch20_scheduler_firestore/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ch20_scheduler_firestore/database/drift_database.dart';
import 'package:get_it/get_it.dart';
import 'package:ch20_scheduler_firestore/provider/schedule_provider.dart';
import 'package:ch20_scheduler_firestore/repository/schedule_repository.dart';
import 'package:provider/provider.dart';
import 'package:ch20_scheduler_firestore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase 프로젝트 설정 함수
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting();

  // 주석 된 부분은 필요가 없는 코드임
  // final database = LocalDatabase(); // 데이터베이스 생성
  // final repository = ScheduleRepository();
  // final scheduleProvider = ScheduleProvider(repository: repository);
  //
  // GetIt.I.registerSingleton<LocalDatabase>(database); //  GetIt에

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}
