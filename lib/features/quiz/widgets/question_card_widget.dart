// question_card.dart
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  const QuestionCard({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
      textAlign: TextAlign.center,
    );
  }
}
