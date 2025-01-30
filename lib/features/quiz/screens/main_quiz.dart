import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

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
  int timer = 30; // Başlangıçta 30 saniye
  late Timer countdownTimer; // Timer için bir değişken
  late ConfettiController _confettiController; // Konfeti kontrolcüsü

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

  @override
  void initState() {
    super.initState();
    startTimer(); // Başlangıçta zamanlayıcıyı başlat
    _confettiController = ConfettiController(duration: const Duration(seconds: 5)); // Konfeti kontrolcüsünü başlat
  }

  @override
  void dispose() {
    countdownTimer.cancel(); // Timer'ı durdurmayı unutma
    _confettiController.dispose(); // Konfeti kontrolcüsünü temizle
    super.dispose();
  }

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
      if (score == questions.length) {
        _confettiController.play(); // Tüm cevaplar doğruysa konfeti patlat
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4), // Arka plan rengi
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Timer'ı üstte gösterelim
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD700), // Timer dairesi rengi (Altın Sarısı)
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
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333), // Metin rengi (Koyu Gri)
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(option),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B), // Buton arka plan rengi (Yeşil)
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
          // Konfeti efekti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive, // Her yöne patlama
              shouldLoop: false, // Tek seferlik patlama
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ], // Konfeti renkleri
            ),
          ),
        ],
      ),
    );
  }
}