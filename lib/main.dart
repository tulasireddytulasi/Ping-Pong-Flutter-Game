import 'package:flame_examples/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const FlutterGames(),
  );
}

class FlutterGames extends StatelessWidget {
  const FlutterGames({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Games',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
