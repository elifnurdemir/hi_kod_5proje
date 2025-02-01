import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../data/questions.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int initialTime = 30;
  int currentQuestionIndex = 0;
  int score = 0;
  int remainingTime = initialTime;
  Timer? countdownTimer;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  void startTimer() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime <= 1) {
        timer.cancel();
        showAlertDialog(
          'Süre Bitti!',
          'Süren doldu, üzgünüm! Tekrar deneyelim mi?',
          resetQuiz,
        );
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  void checkAnswer(String selectedOption) {
    setState(() {
      if (questions[currentQuestionIndex]['answer'] == selectedOption) {
        score += 10;
      }
    });

    countdownTimer?.cancel();

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        remainingTime = initialTime;
      });
      startTimer();
    } else {
      if (score == questions.length * 10) {
        _confettiController.play();
        showAlertDialog(
          'Tebrikler!',
          'Tüm soruları doğru cevapladın, puanın: $score',
          resetQuiz,
        );
      } else {
        showAlertDialog(
          'Maalesef!',
          'Soruları doğru cevaplayamadın. Tekrar dene!',
          resetQuiz,
        );
      }
    }
  }

  void resetQuiz() {
    countdownTimer?.cancel();
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      remainingTime = initialTime;
    });
    startTimer();
  }

  // Daha canlı ve eğlenceli renklerle popup dialog.
  void showAlertDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false, // Dışarı dokununca kapanmasın.
      builder: (_) => AlertDialog(
        backgroundColor: Colors.lightGreen.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Column(
          children: [
            Icon(
              Icons.star,
              size: 48,
              color: Colors.amber, // Amber rengi, sarı tonuna yakın
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepOrangeAccent,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Tekrar Başlayın",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final List<dynamic> options = currentQuestion['options'] as List<dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF4D9),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Üst kısım: kalan süre ve anlık puan göstergesi.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFFF8A65),
                      radius: 40,
                      child: Text(
                        '$remainingTime',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Puan: $score',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  currentQuestion['question'] as String,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E4A59),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ...options.map<Widget>(
                      (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(option.toString()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 70),
                      ),
                      child: Text(
                        option.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
