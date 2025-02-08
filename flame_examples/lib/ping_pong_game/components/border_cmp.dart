import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BorderWall extends RectangleComponent with CollisionCallbacks {
  BorderWall({required Vector2 position, required Vector2 gameSize})
      : super(
          position: position,
          size: gameSize,
          paint: Paint()..color = Colors.green,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox()); // Adds collision detection
  }
}

class BorderComponent extends RectangleComponent {
  BorderComponent(Vector2 gameSize)
      : super(
          size: gameSize,
          paint: Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke // Only stroke (border)
            ..strokeWidth = 50, // Border width
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox()); // Adds collision detection
  }
}
