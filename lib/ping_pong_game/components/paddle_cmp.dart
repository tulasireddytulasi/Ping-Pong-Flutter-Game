import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_examples/ping_pong_game/components/ball_cmp.dart';
import 'package:flame/events.dart';

class Paddle extends RectangleComponent with CollisionCallbacks, DragCallbacks, HasGameRef  {
  final bool isVertical;
  final bool isPlayer;

  Paddle({
    super.position,
    super.size,
    Color? paddleColor,
    this.isVertical = false,
    required this.isPlayer,
  }) : super(
          paint: Paint()..color = paddleColor ?? const Color(0xFFFFFFFF),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    priority = 10;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    priority = 0;
  }

  double borderMargin = 10;
  @override
  void update(double dt) {
    super.update(dt);
    if (!isPlayer) {
      final ball = gameRef.children.firstWhere((child) => child is Ball) as Ball;

      // AI reaction speed - adjust this to make AI more challenging
      const double aiSpeedFactor = 5.0;

      // Target position is aligned with the ball's x position
      double targetX = ball.position.x - size.x / 2;

      // Smoothly move towards the target position using linear interpolation (lerp)
      position.x = lerpDouble(position.x, targetX, dt * aiSpeedFactor)!;

      // Ensure AI paddle stays within bounds
      position.x = position.x.clamp(borderMargin, gameRef.size.x - size.x - borderMargin);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isPlayer) {
      if (isVertical) {
        position.y = (position.y + event.localDelta.y).clamp(0, gameRef.size.y - height);
      } else {
        position.x = (position.x + event.localDelta.x).clamp(0, gameRef.size.x - width);

        /// Prevent the paddle from moving beyond the screen boundaries
        const double borderMargin = 10;
        position.x = position.x.clamp(borderMargin, gameRef.size.x - size.x - borderMargin);
      }
    }
  }
}