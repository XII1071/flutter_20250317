import 'package:ch20_scheduler_firestore/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ch20_scheduler_firestore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase 프로젝트 설정 함수
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}
