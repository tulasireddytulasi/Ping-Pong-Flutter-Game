import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_examples/core/utils/app_constants.dart';
import 'package:flutter/painting.dart';

class CustomButton extends PositionComponent with TapCallbacks, HasVisibility  {
  final String text;
  final VoidCallback onPressed;
  final Paint backgroundPaint = Paint()..color = const Color(0xFF4CAF50); // Green color
  final Paint borderPaint = Paint()
    ..color = const Color(0xFF2E7D32) // Dark green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  late TextComponent textCmp;
  late RectangleComponent rectangleCmp;

  CustomButton({
    required this.text,
    required this.onPressed,
    Vector2? buttonSize,
    Vector2? position,
  }) : super(size: buttonSize ?? Vector2(150, 50), position: position ?? Vector2.zero());

  /// Method to update text dynamically
  void updateText(String newText) {
    textCmp.text = newText;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    rectangleCmp = RectangleComponent(
      size: size,
      paint: backgroundPaint,
    );

    textCmp = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: AppConstants.pressStart2PRegular,
          color: Color(0xFFFFFFFF),
        ),
      ),
      anchor: Anchor.center,
      position: size / 2,
    );

    addAll(
        [rectangleCmp, textCmp,]
    );
  }

  @override
  bool onTapDown(TapDownEvent  event) {
    onPressed();
    priority = 2;
    backgroundPaint.color = const Color(0xFF388E3C); // Darker green on press
    return true;
  }
}
