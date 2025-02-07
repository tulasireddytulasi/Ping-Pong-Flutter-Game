import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_examples/ping_pong_game/components/ball_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/paddle_cmp.dart';

class BouncingBallExample extends FlameGame with HasCollisionDetection { // PanDetector
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  late final Paddle paddle;

  @override
  void onLoad() {
    /// Initialize paddle at bottom center
    paddle = Paddle(
      position: Vector2(size.x / 2 - 50, size.y - 40),
      size: Vector2(100, 20),
    );
    addAll([paddle, ScreenHitbox(), Ball()]);
  }

  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   //super.onPanUpdate(info);
  //   final touchX = info.eventPosition.global.x;
  //   paddle.position.x = (touchX - paddle.width / 2)
  //       .clamp(0, size.x - paddle.width);
  // }
}