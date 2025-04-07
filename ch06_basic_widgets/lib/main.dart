import 'package:ch06_basic_widgets/widgets/elevated_button_widget.dart';
import 'package:ch06_basic_widgets/widgets/floating_action_button_widget.dart';
import 'package:ch06_basic_widgets/widgets/gesture_detector_widget.dart';
import 'package:ch06_basic_widgets/widgets/icon_button_widget.dart';
import 'package:ch06_basic_widgets/widgets/outlined_button_widget.dart';
import 'package:ch06_basic_widgets/widgets/text_button_widget.dart';
import 'package:ch06_basic_widgets/widgets/text_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // child: TextWidgetExample(),
          // child: TextButtonWidgetExample(),
          // child: OutlinedButtonWidgetExample(),
          // child: ElevatedButtonWidgetExample(),
          // child: IconButtonWidgetExample(),
          // child: GestureDetectorWidgetExample(),
          child: FloatingActionButtonWidgetExample(),
        ),
      ),
    );
  }
}
