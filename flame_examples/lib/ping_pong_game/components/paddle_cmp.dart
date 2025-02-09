import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Paddle extends RectangleComponent with CollisionCallbacks { // DragCallbacks
  Paddle({super.position, super.size, Color? paddleColor})
      : super(
          paint: Paint()..color = paddleColor ?? const Color(0xFFBE2417),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  // @override
  // void onDragStart(DragStartEvent event) {
  //   super.onDragStart(event);
  //   priority = 10;
  // }
  //
  // @override
  // void onDragEnd(DragEndEvent event) {
  //   super.onDragEnd(event);
  //   priority = 0;
  // }
  //
  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   position += event.localDelta;
  // }
}