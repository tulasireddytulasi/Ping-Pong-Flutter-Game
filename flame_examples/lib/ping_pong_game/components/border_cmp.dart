import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BorderWall extends RectangleComponent with CollisionCallbacks {
  BorderWall({required Vector2 position, required Vector2 gameSize, Color? color})
      : super(
          position: position,
          size: gameSize,
          paint: Paint()..color = color ?? Colors.green,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox()); // Adds collision detection
  }
}

class BorderComponent extends RectangleComponent {
  static const double margin = 10;
  static const double borderWidth = 4;

  BorderComponent(Vector2 gameSize)
      : super(
          size: gameSize - Vector2.all(2 * margin), // Reduce size by margin
          position: Vector2.all(margin), // Shift position to apply margin
          paint: Paint()
            ..color = Colors.white
             ..style = PaintingStyle.stroke // Only stroke (border)
             ..strokeWidth = borderWidth, // Border width
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox()); // Adds collision detection
  }
}
