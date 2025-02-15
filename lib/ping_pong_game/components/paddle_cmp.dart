import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';

class Paddle extends RectangleComponent with CollisionCallbacks, DragCallbacks, HasGameRef  {
  final bool isVertical;

  Paddle({super.position, super.size, Color? paddleColor, this.isVertical = false})
      : super(
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

  @override
  void onDragUpdate(DragUpdateEvent event) {
   // position += event.localDelta.;
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