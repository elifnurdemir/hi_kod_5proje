// quiz_page.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../data/questions.dart';
import '../widgets/timer_widget.dart';
import '../widgets/question_card_widget.dart';
import '../widgets/options_list_widget.dart';
import '../widgets/confetti_effect_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int initialTimer = 30;
  int currentQuestionIndex = 0, score = 0, timer = initialTimer;
  ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 5));

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkAnswer(String selectedOption) {
    if (questions[currentQuestionIndex]['answer'] == selectedOption) {
      score += 10;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      if (score == questions.length * 10) _confettiController.play();
      showAlertDialog('Quiz Tamamlandı!', 'Puanınız: \$score', resetQuiz);
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  void showAlertDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content, style: const TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Yeniden Başlayın'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TimerWidget(timer: timer),
                QuestionCard(question: questions[currentQuestionIndex]['question']),
                OptionsList(
                  options: questions[currentQuestionIndex]['options'],
                  onOptionSelected: checkAnswer,
                ),
              ],
            ),
          ),
          ConfettiEffect(controller: _confettiController),
        ],
      ),
    );
  }
}