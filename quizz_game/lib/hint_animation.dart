import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';

class HintAnimation extends SpriteAnimationComponent with HasGameRef {
  final VoidCallback onHintCompleted;
  bool hasDelivered = false;

  HintAnimation({required this.onHintCompleted});

  @override
  Future<void> onLoad() async {
    final spriteSheet = await gameRef.images.load('walk_spritesheet.png');
    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(64, 64),
        stepTime: 0.1,
      ),
    );
    size = Vector2(64, 64);
    position = Vector2(-64, gameRef.size.y - 128); // Start offscreen
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!hasDelivered) {
      position.x += 100 * dt; // Move the figure
      if (position.x > gameRef.size.x / 2) {
        deliverHint();
      }
    }
  }

  void deliverHint() {
    hasDelivered = true;
    Future.delayed(
        Duration(seconds: 2), onHintCompleted); // Delay before hint completion
  }
}
