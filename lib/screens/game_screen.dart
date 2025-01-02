import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:wordle/game_logic.dart';
import 'package:wordle/provider/text_input_provider.dart';
import 'package:wordle/widgets/custom_dialog.dart';
import 'package:wordle/widgets/keyboard_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textInputNotifier = ref.read(textInputProvider.notifier);
    final showClues = ref.watch(textInputProvider).showClues;
    final isWon = ref.watch(textInputProvider).isWon;
    final displayText = showAnswer(ref);

    var defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), border: Border.all(color: Colors.grey)),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
    if (isWon) {
      return Center(
          child: Container(color: Colors.green, child: const CustomDialog()));
    }

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            displayText,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ((showClues)? showAllClues(ref): const SizedBox()),
          Container(
            child: Pinput(
              defaultPinTheme: defaultPinTheme,
              length: 5,
              controller: textInputNotifier.controller,
            ),
          ),
          SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: const KeyboardWidget(),
          ),

        ],
      ),
    );
  }
}
