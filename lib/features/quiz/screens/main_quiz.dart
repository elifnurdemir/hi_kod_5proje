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
    // Önceki timer varsa iptal edelim.
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime <= 1) {
        timer.cancel();
        showAlertDialog(
          'Süre Bitti!',
          'Süreniz doldu, kaybettiniz. Tekrar deneyiniz.',
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
    // Puan artışını setState içerisine alarak UI'nın güncellenmasını sağlıyoruz.
    setState(() {
      if (questions[currentQuestionIndex]['answer'] == selectedOption) {
        score += 10;
      }
    });

    // Timer'ı iptal edelim.
    countdownTimer?.cancel();

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        remainingTime = initialTime;
      });
      startTimer();
    } else {
      // Son soruda doğru cevap verildiğinde UI da güncellenmiş olacak.
      if (score == questions.length * 10) {
        _confettiController.play();
      }
      showAlertDialog('Quiz Tamamlandı!', 'Puanınız: $score', resetQuiz);
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

  void showAlertDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false, // Dışarı dokununca kapanmasın.
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Yeniden Başlayın'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mevcut sorunun verisinin tip dönüşümünü yapıyoruz:
    final currentQuestion = questions[currentQuestionIndex];
    final List<dynamic> options = currentQuestion['options'] as List<dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
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
                      backgroundColor: const Color(0xFFFFD700),
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
                        color: Colors.blueAccent,
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
                    color: Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Spread operatöründe toList()'e gerek yok.
                ...options.map<Widget>(
                      (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(option.toString()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 70),
                      ),
                      child: Text(
                        option.toString(),
                        style:
                        const TextStyle(fontSize: 20, color: Colors.white),
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
