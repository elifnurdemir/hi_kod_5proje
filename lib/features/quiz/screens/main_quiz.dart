import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:hi_kod_5proje/components/custom_app_bar.dart';
import '../data/questions.dart';
import '../widgets/timer_widget.dart';
import '../widgets/score_widget.dart';
import '../widgets/question_widget.dart';
import '../widgets/alert_dialog_widget.dart';

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

  late List<Map<String, dynamic>> selectedQuestions;

  @override
  void initState() {
    super.initState();

    final randomListIndex = (DateTime.now().millisecondsSinceEpoch % 3);
    selectedQuestions = randomListIndex == 0
        ? EgitimHakkiList
        : randomListIndex == 1
        ? SaglikHakkiList
        : EsitlikHakkiList;

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
      if (selectedQuestions[currentQuestionIndex]['answer'] == selectedOption) {
        score += 10;
      }
    });

    countdownTimer?.cancel();

    if (currentQuestionIndex < selectedQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      startTimer();
    } else {
      if (score == selectedQuestions.length * 10) {
        _confettiController.play();
        showAlertDialog(
          'Tebrikler!',
          'Tüm soruları doğru cevapladın! Bir rozet kazandın! Puanın: $score',
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
    _confettiController.stop();
    startTimer();
  }

  void showAlertDialog(String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialogWidget(
        title: title,
        content: content,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = selectedQuestions[currentQuestionIndex];
    final options = List<String>.from(currentQuestion['options']);

    return Scaffold(
      appBar: CustomAppBar(),
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
                    TimerWidget(
                      remainingTime: remainingTime,
                      isTimerRunning: isTimerRunning,
                      onPause: stopTimer,
                      onResume: resumeTimer,
                    ),
                    ScoreWidget(score: score),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: QuestionWidget(
                    question: currentQuestion['question'],
                    options: options,
                    onAnswerSelected: checkAnswer,
                    isTimerRunning: isTimerRunning,
                  ),
                ),
              ),
            ],
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
