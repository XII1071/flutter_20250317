import 'package:ch18_scheduler_sqlite/database/drift_database.dart';
import 'package:ch18_scheduler_sqlite/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ko_KR');

  final database = LocalDatabase(); // 데이터베이스 생성

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}
