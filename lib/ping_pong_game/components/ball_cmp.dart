import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_examples/core/utils/enums.dart';
import 'package:flame_examples/ping_pong_game/ping_pong_game.dart';
import 'package:flame_examples/ping_pong_game/components/border_cmp.dart';
import 'package:flame_examples/ping_pong_game/components/paddle_cmp.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent with HasGameReference<PingPongGame>, CollisionCallbacks {
  late Vector2 velocity;

  Ball() {
    paint = Paint()..color = Colors.white;
    radius = 10;
  }

  static const double speed = 350;
  static const degree = math.pi / 180;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _init;
    final hitBox = CircleHitbox(
      radius: radius,
    );

    addAll([
      hitBox,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if ((game.gameState == GameState.gameOver) || game.gameState == GameState.paused) return;
    if (game.gameState == GameState.playing) {
      position += velocity * dt;
    }
  }

  void get _init => position = game.size / 2;

  void get _playButtonVisible => game.playButton.isVisible = !game.playButton .isVisible;

  void get _resetBall {
    position = game.size / 2;
    final spawnAngle = getSpawnAngle;
    final vx = math.cos(spawnAngle * degree) * speed;
    final vy = math.sin(spawnAngle * degree) * speed;
    velocity = Vector2(
      vx,
      vy,
    );
  }

  double get getSpawnAngle {
    final random = math.Random().nextDouble();
    // [spawnAngle] Ensures ball moves in an upward direction
    final spawnAngle = lerpDouble(30, 150, random)!;
    return spawnAngle;
  }

  void gameOver() {
    game.playButton.updateText("Game Over!");
    _playButtonVisible;
    game.gameState = GameState.gameOver;
  }

  void restartGame() {
    _playButtonVisible;
    _resetBall;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    const double margin = 10; // Border margin for collision detection
    const double tolerance = 2.0; // Small margin for error correction (floating-point precision)

    // Get the first point of collision
    final collisionPoint = intersectionPoints.first;

    // Collision with screen edges
    if (other is ScreenHitbox) {
      // Left or Right Edge Collision
      if ((collisionPoint.x).abs() < tolerance || (collisionPoint.x - game.size.x).abs() < tolerance) {
        velocity.x = -velocity.x; // Reverse X-direction
      }

      // Top or Bottom Edge Collision
      if ((collisionPoint.y).abs() < tolerance || (collisionPoint.y - game.size.y).abs() < tolerance) {
        velocity.y = -velocity.y; // Reverse Y-direction
      }
    }
    // Collision with the BorderComponent (with margin considered)
    else if (other is BorderComponent) {
      // Left or Right Border Collision
      if ((collisionPoint.x - margin).abs() < tolerance ||
          (collisionPoint.x - (game.size.x - margin)).abs() < tolerance) {
        velocity.x = -velocity.x; // Reverse X-direction
      }

      // Top or Bottom Border Collision
      if ((collisionPoint.y - margin).abs() < tolerance ||
          (collisionPoint.y - (game.size.y - margin)).abs() < tolerance) {
        double diff = (collisionPoint.y - (game.size.y - margin)).abs();

        if (diff < tolerance) { // Use tolerance for floating-point comparison
          gameOver();
          return;
        }

        velocity.y = -velocity.y; // Reverse Y-direction
      }
    }
    // Collision with the BorderWall (like a paddle)
    else if (other is BorderWall) {
      // Get BorderWall (Paddle) boundaries
      final paddleLeft = other.position.x;
      final paddleRight = paddleLeft + other.size.x;
      final paddleTop = other.position.y;
      final paddleBottom = paddleTop + other.size.y;

      // Get Ball's center position
      final ballCenterX = position.x + radius;
      final ballCenterY = position.y + radius;

      // Ball hits the top or bottom of the paddle
      if (ballCenterX > paddleLeft &&
          ballCenterX < paddleRight &&
          collisionPoint.y >= paddleTop &&
          collisionPoint.y <= paddleBottom) {
        velocity.y = -velocity.y; // Reverse Y-direction
      }

      // Ball hits the left or right of the paddle
      if (ballCenterY > paddleTop &&
          ballCenterY < paddleBottom &&
          collisionPoint.x >= paddleLeft &&
          collisionPoint.x <= paddleRight) {
        velocity.x = -velocity.x; // Reverse X-direction
      }
    }
    // Collision with the Paddle
    else if (other is Paddle) {
      velocity.y = -velocity.y; // Reverse Y-direction when hitting the paddle
    }
  }
}
