import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/game_logic.dart';
import 'package:wordle/provider/text_input_provider.dart';
import 'package:wordle/widgets/keyboard_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late Future<String> actualWord;

  @override
  void initState() {
    super.initState();
    actualWord = fetchWord();
  }

  @override
  Widget build(BuildContext context) {
    final textInputNotifier = ref.read(textInputProvider.notifier);

    return Center(
      child: Column(
        children: [
          FutureBuilder(
              future: actualWord,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Text(
                  snapshot.data ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                );
              }),

          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              textCapitalization: TextCapitalization.characters,
              maxLength: 5,
              controller: textInputNotifier.controller,
              keyboardType: TextInputType.none,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          // const Spacer(),
          Container(
              margin: EdgeInsets.only(bottom: 32),
              child: const KeyboardWidget())
        ],
      ),
    );
  }
}
