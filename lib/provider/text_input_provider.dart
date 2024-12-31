import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WordCheck{
// List<String> clues;
// String actualWord;
// String currentWord;
//
// WordCheck({required this.clues, required this.actualWord, required this.currentWord});
//
// WordCheck copyWith({
//   List<String>? clues,
//   String? actualWord,
//   String? currentWord
// }) {
//     return WordCheck(
//       clues: clues ?? this.clues,
//       actualWord: actualWord ?? this.actualWord,
//       currentWord: currentWord ?? this.currentWord,
//     );
//   }
// }

class TextInputNotifier extends StateNotifier<String> {
  final TextEditingController controller = TextEditingController();

  TextInputNotifier({wordCheck}) : super(wordCheck);

  void addChar(String letter) {
    if(state.length<5) {
      state += letter;
      controller.text = state;
    }
  }

  void removeChar() {
    if (state.isNotEmpty) {
      state = state.substring(0, state.length - 1);
      controller.text = state;
    }
  }

  void enterChar() {
    //   TODO: Need to define
  }
}

final textInputProvider = StateNotifierProvider<TextInputNotifier,String>((ref) {
  return TextInputNotifier();
});
