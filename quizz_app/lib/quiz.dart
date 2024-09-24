import 'package:flutter/material.dart';
import 'package:quizz_app/start_screen.dart';
import 'package:quizz_app/questions_screen.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:quizz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String?> _selectedAnswers = List<String?>.filled(questions.length, null);
  var _activeScreen = 'start-screen';
  int currentQuestionIndex = 0;

  void _switchScreen() {
    setState(() {
      _activeScreen = 'questions-screen';
    });
  }

  void _chooseAnswer(String answer) {
    // Store the selected answer
    _selectedAnswers[currentQuestionIndex] = answer;

    // Check if all answers are filled
    if (_selectedAnswers.every((answer) => answer != null)) {
      setState(() {
        _activeScreen = 'results-screen'; // Go to results if all answered
      });
    } else {
      // Move to the next question
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      }
    }
  }

  void _goBack() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _activeScreen = 'questions-screen';
      currentQuestionIndex = 0;
      _selectedAnswers =
          List<String?>.filled(questions.length, null); // Reset answers
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(_switchScreen);

    if (_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: _chooseAnswer,
        currentQuestionIndex: currentQuestionIndex,
        totalQuestions: questions.length,
        onBack: _goBack, // Pass back functionality
      );
    }

    if (_activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
