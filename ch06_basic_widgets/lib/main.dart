import 'package:ch06_basic_widgets/design_widget/container_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/elevated_button_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/floating_action_button_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/gesture_detector_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/icon_button_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/outlined_button_widget.dart';
import 'package:ch06_basic_widgets/design_widget/padding_widget.dart';
import 'package:ch06_basic_widgets/design_widget/safe_area_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/text_button_widget.dart';
import 'package:ch06_basic_widgets/basic_widgets/text_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/absolute_layout_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/column_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/expanded_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/flexible_expanded_mixed_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/flexible_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/login_screen.dart';
import 'package:ch06_basic_widgets/layout_widget/row_widget.dart';
import 'package:ch06_basic_widgets/layout_widget/stack_widget.dart';
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
          // child: FloatingActionButtonWidgetExample(),
          // child: ContainerWidgetExample(),
          // child: PaddingWidgetExample(),
          // child: SafeAreaWidgetExample(),
          // child: RowWidgetExample(),
          // child: ColumnWidgetExample(),
          // child: FlexibleWidgetExample(),
          // child: ExpandedWidgetExample(),
          // child: FlexibleExpandedMixedWidgetExample(),
          // child: StackWidgetExample(),
          // child: AbsoluteLayoutWidgetExample(),
          child: LoginScreen(),
        ),
      ),
    );
  }
}

