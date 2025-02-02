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
  bool isTimerRunning = true;

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
        setState(() {
          remainingTime = 0;
        });
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

  void stopTimer() {
    countdownTimer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void resumeTimer() {
    setState(() {
      isTimerRunning = true;
    });
    startTimer();
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
      isTimerRunning = true;
    });
    _confettiController.stop(); // Konfeti animasyonunu durdur
    startTimer();
  }

  void showAlertDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          AlertDialog(
            backgroundColor: Colors.lightGreen.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: Column(
              children: [
                Icon(
                  Icons.star,
                  size: 48,
                  color: Colors.amber,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                                  value: remainingTime / initialTime,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white10,
                                  valueColor: const AlwaysStoppedAnimation<
                                      Color>(Colors.deepOrangeAccent),
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
                        // Timer ile buton arasına boşluk ekledik
                        Container(
                          decoration: BoxDecoration(
                            color: isTimerRunning ? Colors.redAccent : Colors
                                .green,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              isTimerRunning ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            iconSize: 32,
                            onPressed: () {
                              if (isTimerRunning) {
                                stopTimer();
                              } else {
                                resumeTimer();
                              }
                            },
                          ),
                        ),
                      ],
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
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options
                    .map<Widget>(
                      (option) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton(
                          onPressed: isTimerRunning ? () =>
                              checkAnswer(option.toString()) : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isTimerRunning ? const Color(
                                0xFF00C853) : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            minimumSize: const Size(double.infinity, 60),
                            elevation: isTimerRunning ? 5 : 0,
                          ),
                          child: Text(
                            option.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: isTimerRunning ? Colors.white : Colors
                                  .black54,
                            ),
                          ),
                        ),
                      ),
                )
                    .toList(),
              ),
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