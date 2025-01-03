import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:wordle/game_logic.dart';
import 'package:wordle/provider/text_input_provider.dart';
import 'package:wordle/widgets/custom_dialog.dart';
import 'package:wordle/widgets/keyboard_widget.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textInputNotifier = ref.read(textInputProvider.notifier);
    final showClues = ref.watch(textInputProvider).showClues;
    final isWon = ref.watch(textInputProvider).isWon;
    final displayText = showAnswer(ref);
    final noOfChances = ref.watch(textInputProvider).noOfChances;

    var defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
    if (isWon) {
      return Center(
        child: Container(
          color: Colors.green,
          child: const CustomDialog(
              title: 'You Won', subTitle: 'You Guessed the correct answer'),
        ),
      );
    } else if (noOfChances < 1) {
      return Center(
        child: Container(
          color: Colors.redAccent,
          child: const CustomDialog(
              title: 'You Lose', subTitle: 'You are out of chances'),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          displayText,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        ((showClues) ? showAllClues(ref) : const SizedBox()),
        Pinput(
          defaultPinTheme: defaultPinTheme,
          length: 5,
          controller: textInputNotifier.controller,
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: const KeyboardWidget(),
        ),
        const SizedBox(height: 50)
      ],
    );
  }
}
