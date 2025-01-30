import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../data/questions.dart';


void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int initialTimer = 30;
  int currentQuestionIndex = 0, score = 0, timer = initialTimer;
  Timer? countdownTimer;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.timer <= 1) {
        timer.cancel();
        showAlertDialog('Süre Bitti!', 'Süreniz doldu, kaybettiniz. Tekrar deneyiniz.', resetQuiz);
      } else {
        setState(() => this.timer--);
      }
    });
  }

  void checkAnswer(String selectedOption) {
    if (questions[currentQuestionIndex]['answer'] == selectedOption) {
      score+=10;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        timer = initialTimer;
      });
    } else {
      if (score == questions.length * 10) _confettiController.play();
      showAlertDialog('Quiz Tamamlandı!', 'Puanınız: $score', resetQuiz);
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      timer = initialTimer;
    });
    startTimer();
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
                Center(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFFFD700),
                    radius: 50,
                    child: Text('$timer', style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  questions[currentQuestionIndex]['question'],
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ...questions[currentQuestionIndex]['options'].map<Widget>((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      minimumSize: const Size(double.infinity, 70),
                    ),
                    child: Text(option, style: const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }
}
