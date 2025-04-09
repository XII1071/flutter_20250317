import 'package:ch09_pageview/screen/home_screen_stateful.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: const HomeScreen()
          home: const HomeScreenStateful()
      ));
}