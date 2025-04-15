import 'package:flutter/material.dart';
import 'package:soul_talk/component/point_notification.dart';

class Message extends StatelessWidget {
  final bool alignLeft;
  final String message;
  final int? point;

  const Message({
    super.key,
    this.alignLeft = true,
    this.point,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = alignLeft ? Alignment.centerLeft : Alignment.centerRight;
    final bgColor = alignLeft ? const Color(0xFFF4F4F4) : Colors.white;
    final border = alignLeft ? const Color(0xFFE7E7E7) : Colors.black12;

    return Column(
      children: [
        Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: bgColor,
              border: Border.all(
                color: border,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        if (point != null)
          Align(
            alignment: alignment,
            child: PointNotification(
              point: point!,
            ),
          ),
      ],
    );
  }
}
