import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;
import 'button_component.dart';
import 'hint_animation.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'main.dart';

class QuizPopup extends PositionComponent with HasGameRef<HelpdeskGame> {
  late TextComponent questionText;
  late List<ButtonComponent> answerButtons;
  late ButtonComponent hintButton;
  bool hintUsed = false;

  @override
  Future<void> onLoad() async {
    size = Vector2(500, 300);
    position = Vector2(100, 100);

    // Quiz question
    questionText = TextComponent(
      text: 'What does HTTP stand for?',
      position: Vector2(50, 50),
    );
    add(questionText);

    // Answer buttons
    answerButtons = [
      createAnswerButton('Hypertext Transfer Protocol', true, Vector2(50, 100)),
      createAnswerButton('Home Tool Text Page', false, Vector2(50, 150)),
      createAnswerButton(
          'Hyper Transfer Text Program', false, Vector2(50, 200)),
      createAnswerButton(
          'Hyperlink Transfer Protocol', false, Vector2(50, 250)),
    ];

    for (var button in answerButtons) {
      add(button);
    }

    // Hint button
    hintButton = ButtonComponent(
      buttonText: 'Hint',
      position: Vector2(50, 300),
      onPressed: onHintPressed,
    );
    add(hintButton);
  }

  ButtonComponent createAnswerButton(
      String answer, bool isCorrect, Vector2 pos) {
    return ButtonComponent(
      buttonText: answer,
      position: pos,
      onPressed: () {
        if (isCorrect) {
          print('Correct answer!');
        } else {
          print('Wrong answer!');
        }
      },
    );
  }

  void onHintPressed() {
    hintUsed = true;
    gameRef.removeQuizPopup(); // Temporarily hide quiz popup
    gameRef.add(HintAnimation(onHintCompleted: () {
      // Once hint animation is complete, show the quiz popup again
      gameRef.showQuizPopup();
      highlightCorrectAnswer();
    }));
  }

  void highlightCorrectAnswer() {
    // Highlight the correct answer button after hint is used
    for (var button in answerButtons) {
      if (button.isCorrect) {
        button.highlight();
      }
    }
  }
}
