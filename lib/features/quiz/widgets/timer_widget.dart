// timer_widget.dart
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int timer;
  const TimerWidget({required this.timer, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: const Color(0xFFFFD700),
        radius: 50,
        child: Text('$timer', style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}