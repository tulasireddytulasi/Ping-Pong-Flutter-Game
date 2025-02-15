import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_examples/core/utils/enums.dart';
import 'package:flame_examples/ping_pong_game/components/ball_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/border_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/paddle_cmp.dart';

import 'components/button.dart';

class BouncingBallExample extends FlameGame with HasCollisionDetection {
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  late final Paddle paddle, rightPaddle;
  late Ball ball;
  late CustomButton playButton;
  GameState gameState = GameState.intro;

  @override
  void onLoad() {
    /// Initialize paddle at bottom center
    paddle = Paddle(
      position: Vector2((size.x * 0.5) - 100, size.y - 50),
      size: Vector2(200, 20),
    );

    ball = Ball();

    playButton = CustomButton(
      text: "Start Gamer!",
      onPressed: () {
        gameState = GameState.playing;
        print("Button Pressed!");
        ball.restartGame();
      },
      buttonSize: Vector2(260, 55),
      position: Vector2((size.x * 0.5) - 130, size.y * 0.3),
    );

    addAll([
      playButton,
      paddle,
      ball,
      ScreenHitbox(),
      BorderComponent(size),
    ]);
  }
}
