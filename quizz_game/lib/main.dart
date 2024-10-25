import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'quiz_popup.dart';

void main() {
  runApp(GameWidget(game: HelpdeskGame()));
}

class HelpdeskGame extends FlameGame {
  late QuizPopup quizPopup;

  @override
  Future<void> onLoad() async {
    quizPopup = QuizPopup();
    add(quizPopup);
  }

  // A method to temporarily remove the quiz popup for hint animation
  void removeQuizPopup() {
    remove(quizPopup);
  }

  // A method to show the quiz popup again after hint animation
  void showQuizPopup() {
    add(quizPopup);
  }
}
