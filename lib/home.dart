import 'package:flame/game.dart';
import 'package:flame_examples/ping_pong_game/ping_pong_game.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Ping Pong Games"),
      ),
      body: Container(
        color: Colors.black,
        margin: const EdgeInsets.all(0),
        child: ClipRect(
          child: GameWidget(
            game: PingPongGame(),
            loadingBuilder: (_) => const Center(
              child: Text('Loading'),
            ),
          ),
        ),
      ),
    );
  }
}
