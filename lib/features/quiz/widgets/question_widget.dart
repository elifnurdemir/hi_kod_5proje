import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final void Function(String) onAnswerSelected;
  final bool isTimerRunning;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.options,
    required this.onAnswerSelected,
    required this.isTimerRunning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E4A59),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ...options.map((option) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ElevatedButton(
            onPressed: isTimerRunning ? () => onAnswerSelected(option) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isTimerRunning ? const Color(0xFF00C853) : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              minimumSize: const Size(double.infinity, 60),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 20,
                color: isTimerRunning ? Colors.white : Colors.black54,
              ),
            ),
          ),
        ))
      ],
    );
  }
}
