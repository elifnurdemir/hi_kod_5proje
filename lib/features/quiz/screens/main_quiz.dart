import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  int timer = 24000; // Başlangıçta 30 saniye
  late Timer countdownTimer; // Timer için bir değişken

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Bir yıl kaç ay içerir?',
      'options': ['10', '12', '8', '11'],
      'answer': '12',
    },
    {
      'question': 'Türkiye’nin başkenti neresidir?',
      'options': ['İstanbul', 'Ankara', 'İzmir', 'Bursa'],
      'answer': 'Ankara',
    },
    {
      'question': 'Güneş sistemi kaç gezegen içerir?',
      'options': ['7', '8', '9', '6'],
      'answer': '8',
    },
  ];

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--; // Sayacı her saniye bir azalt
        } else {
          countdownTimer.cancel(); // Zaman dolduğunda timer'ı durdur
          _showTimeoutDialog(); // Süre dolduğunda gösterilecek diyalog
        }
      });
    });
  }

  void _showTimeoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Süre Bitti!'),
        content: const Text('Süreniz doldu, kaybettiniz. Tekrar deneyin.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetQuiz(); // Quiz'i sıfırlayıp yeniden başlat
            },
            child: const Text('Yeniden Başla'),
          ),
        ],
      ),
    );
  }

  void checkAnswer(String selectedOption) {
    if (questions[currentQuestionIndex]['answer'] == selectedOption) {
      setState(() {
        score++;
      });
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quiz Tamamlandı!'),
          content: Text('Puanınız: $score/${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
              child: const Text('Yeniden Başla'),
            ),
          ],
        ),
      );
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      timer = 30; // Zamanı sıfırla
    });
    startTimer(); // Zamanlayıcıyı yeniden başlat
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Başlangıçta zamanlayıcıyı başlat
  }

  @override
  void dispose() {
    countdownTimer.cancel(); // Timer'ı durdurmayı unutma
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Zamanı'),
        centerTitle: true,
        backgroundColor: ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer'ı dairenin içinde gösterelim
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent,
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  '$timer', // Sayacın değeri burada gösteriliyor
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  child: Text(option, style: const TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    minimumSize: const Size(0, 70),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
