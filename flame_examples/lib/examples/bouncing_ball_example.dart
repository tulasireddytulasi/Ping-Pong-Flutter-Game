import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BouncingBallExample extends FlameGame with HasCollisionDetection, PanDetector {
  static const description = '''
    This example shows how you can use the Collisions detection api to know when a ball
    collides with the screen boundaries and then update it to bounce off these boundaries.
  ''';
  late final Paddle paddle;

  @override
  void onLoad() {
    // Initialize paddle at bottom center
    paddle = Paddle(
      position: Vector2(size.x / 2 - 50, size.y - 40),
      size: Vector2(100, 20),
    );
   // add(paddle);
    addAll([
      paddle,
      ScreenHitbox(),
      Ball(),
    ]);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    //super.onPanUpdate(info);
    final touchX = info.eventPosition.global.x;
    paddle.position.x = (touchX - paddle.width / 2)
        .clamp(0, size.x - paddle.width);
  }
}

class Paddle extends RectangleComponent with CollisionCallbacks {
  Paddle({super.position, super.size})
      : super(
    paint: Paint()..color = const Color(0xFF0099FF),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }
}

class Ball extends CircleComponent with HasGameReference<FlameGame>, CollisionCallbacks {
  late Vector2 velocity;

  Ball() {
    paint = Paint()..color = Colors.white;
    radius = 10;
  }

  static const double speed = 500;
  static const degree = math.pi / 180;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _resetBall;
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
    position += velocity * dt;
  }

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
    final spawnAngle = lerpDouble(0, 360, random)!;

    return spawnAngle;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final collisionPoint = intersectionPoints.first;

      // Left Side Collision
      if (collisionPoint.x == 0) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Right Side Collision
      if (collisionPoint.x == game.size.x) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }
      // Top Side Collision
      if (collisionPoint.y == 0) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // Bottom Side Collision
      if (collisionPoint.y == game.size.y) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
    } else  if (other is Paddle) {
      velocity.y = -velocity.y; // Reverse Y-direction when hitting the paddle
    }
  }
}
