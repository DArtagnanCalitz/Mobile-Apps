import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;

class ButtonComponent extends PositionComponent {
  final String buttonText;
  final material.VoidCallback onPressed;
  bool isCorrect;
  late material.Paint buttonPaint;
  late TextPaint textPaint;

  ButtonComponent({
    required this.buttonText,
    required this.onPressed,
    this.isCorrect = false,
  });

  @override
  Future<void> onLoad() async {
    size = Vector2(200, 50);
    buttonPaint = material.Paint()..color = material.Colors.blue;

    // Set up text rendering
    textPaint = TextPaint(
      style: material.TextStyle(
        color: material.Colors.white,
        fontSize: 18,
      ),
    );

    add(TapGestureRecognizer(onTap: () => onPressed())); // Handle button tap
  }

  @override
  void render(Canvas canvas) {
    // Draw button background
    canvas.drawRect(size.toRect(), buttonPaint);

    // Draw button text
    textPaint.render(canvas, buttonText, Vector2(size.x / 4, size.y / 4));
  }

  void highlight() {
    // Change color to highlight correct answer
    buttonPaint.color = material.Colors.green;
  }
}
