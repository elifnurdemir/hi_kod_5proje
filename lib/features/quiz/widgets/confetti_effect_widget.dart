// confetti_effect.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiEffect extends StatelessWidget {
  final ConfettiController controller;
  const ConfettiEffect({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
      ),
    );
  }
}
