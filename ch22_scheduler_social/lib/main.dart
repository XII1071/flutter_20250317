import 'package:ch22_scheduler_social/firebase_options.dart';
import 'package:ch22_scheduler_social/screen/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen()));
}
