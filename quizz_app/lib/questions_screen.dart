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
    required this.onBack,
    required this.onSkip, // Add onSkip parameter
    required this.isQuestionAnswered, // Track if question is answered
  });

  final void Function(String answer) onSelectAnswer;
  final int currentQuestionIndex;
  final int totalQuestions;
  final void Function() onBack;
  final void Function() onSkip; // Add onSkip function
  final bool
      isQuestionAnswered; // New parameter to track if question is answered

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100), // Add spacing for the back button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentQuestion.text,
                  style: GoogleFonts.lato(
                    color: Colors.white,
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
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20), // Add spacing for the back button
                Center(
                  child: Text(
                    "Question ${currentQuestionIndex + 1} of $totalQuestions",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Add spacing for the back button
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: currentQuestionIndex / totalQuestions,
                  ),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 47, 47, 47)),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing for the back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        onBack(); // Call the back function when clicked
                      },
                      child: Text(
                        'Back',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: isQuestionAnswered
                          ? null
                          : onSkip, // Disable if question is answered
                      child: Text(
                        'Skip',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
