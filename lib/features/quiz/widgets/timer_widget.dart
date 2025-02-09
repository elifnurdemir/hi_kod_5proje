import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int remainingTime;
  final bool isTimerRunning;
  final VoidCallback onPause;
  final VoidCallback onResume;

  const TimerWidget({
    Key? key,
    required this.remainingTime,
    required this.isTimerRunning,
    required this.onPause,
    required this.onResume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 42,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: remainingTime / 30,
                  strokeWidth: 8,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
              ),
              CircleAvatar(
                backgroundColor: const Color(0xFFF3D720),
                radius: 35,
                child: Text(
                  '$remainingTime',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: isTimerRunning ? Colors.redAccent : Colors.green,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isTimerRunning ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            iconSize: 32,
            onPressed: isTimerRunning ? onPause : onResume,
          ),
        ),
      ],
    );
  }
}
