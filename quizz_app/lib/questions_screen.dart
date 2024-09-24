import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/answer_button.dart';
import 'package:quizz_app/data/questions.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.onBack, // Add onBack parameter
  });

  final void Function(String answer) onSelectAnswer;
  final int currentQuestionIndex;
  final int totalQuestions;
  final void Function() onBack; // Add onBack function

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.shuffledAnswers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  onSelectAnswer(answer);
                },
              );
            }),
            const SizedBox(height: 20), // Add spacing for the back button
            TextButton(
              onPressed: () {
                onBack(); // Call the back function when clicked
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
