import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/game_logic.dart';
import 'package:wordle/screens/game_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black87),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(
        child: Scaffold(
          body: GameScreen(),
        ),
      ),
    );
  }
}
