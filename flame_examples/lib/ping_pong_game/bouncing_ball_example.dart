import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_examples/ping_pong_game/components/ball_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/border_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/paddle_cmp.dart';

class BouncingBallExample extends FlameGame with HasCollisionDetection { // PanDetector
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  late final Paddle paddle, rightPaddle;

  @override
  void onLoad() {
    /// Initialize paddle at bottom center
    paddle = Paddle(
      position: Vector2(size.x / 2 - 50, size.y - 50),
      size: Vector2(100, 20),
    );
    rightPaddle = Paddle(
      position: Vector2(size.x - 50, size.y / 2 - 50),
      size: Vector2(20, 200),
      isVertical: true,
    );
    addAll([
      paddle,
     // rightPaddle,
      Ball(),
      ScreenHitbox(),
      BorderComponent(size),
      // Bottom Wall
      // BorderWall(position: Vector2(50, size.y - 50), gameSize: Vector2(size.x - 80, 20), color: Colors.yellow),
      // BorderWall(position: Vector2(size.x - 50, 50), gameSize: Vector2(20, size.y - 100)), // Right Wall
      // BorderWall(position: Vector2(50, 50), gameSize: Vector2(size.x - 100, 20), color: Colors.purple), // Top Wall
      // BorderWall(position: Vector2(50, 50), gameSize: Vector2(20, size.y - 100), color: Colors.blue), // Left Wall
    ]);
  }

  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   super.onPanUpdate(info);
  //   final touchX = info.eventPosition.global.x;
  //   paddle.position.x = (touchX - paddle.width / 2).clamp(0, size.x - paddle.width);
  // }
}
