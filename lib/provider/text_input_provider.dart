import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordCheck {
  List<String> userWords;
  String actualWord;
  String currentWord;
  bool isMatched;
  bool isWordEntered;
  List<Widget> clues;

  WordCheck({required this.userWords,
    required this.actualWord,
    required this.currentWord,
    required this.isMatched,
    required this.isWordEntered,
    required this.clues});

  WordCheck copyWith({List<String>? userWords,
    String? actualWord,
    String? currentWord,
    bool? isMatched,
    bool? isWordEntered,
    List<Widget>? clues}) {
    return WordCheck(
        userWords: userWords ?? this.userWords,
        actualWord: actualWord ?? this.actualWord,
        currentWord: currentWord ?? this.currentWord,
        isMatched: isMatched ?? this.isMatched,
        clues: clues ?? this.clues,
        isWordEntered: isWordEntered ?? this.isWordEntered);
  }
}

class TextInputNotifier extends StateNotifier<WordCheck> {
  final TextEditingController controller = TextEditingController();

  TextInputNotifier({wordCheck}) : super(wordCheck);


  void addChar(String letter) {
    if (state.currentWord.length < 5) {
      state = state.copyWith(currentWord: state.currentWord + letter);
      controller.text = state.currentWord;
    }
  }

  void removeChar() {
    if (state.currentWord.isNotEmpty) {
      state = state.copyWith(
          currentWord:
          state.currentWord.substring(0, state.currentWord.length - 1));
      controller.text = state.currentWord;
    }
  }

  void enterChar() {
    // String actualWordReceived = await fetchWord();
    // state = state.copyWith(actualWord: actualWordReceived);
    if (state.currentWord.length == 5) {
      if (state.actualWord == state.currentWord) {
        state = state.copyWith(
          isWordEntered: true,
          isMatched: true,
          userWords: [...state.userWords, state.currentWord],
          currentWord: '',
        );
      } else {
        state = state.copyWith(
          isWordEntered: true,
          isMatched: false,
          userWords: [...state.userWords, state.currentWord],
          currentWord: '',
        );
      }
    } else {
      print("Word is not completed");
      state = state.copyWith(isWordEntered: false);
    }
    controller.clear();

  }

  void getClues() {
    String currentWord = state.currentWord;
    String actualWord = state.actualWord;
    List<TextSpan> letters = [];
    for (int i = 0; i < actualWord.length; i++) {
      if (currentWord[i] == actualWord[i]) {
        // newClue["actual"]?.add(currentWord[i]);
        letters.add(TextSpan(text: currentWord[i],style: const TextStyle(color: Colors.green)));
        // Text()
      } else if (actualWord.contains(currentWord[i])) {
        letters.add(TextSpan(text: currentWord[i],style: const TextStyle(color: Colors.orange)));

        // newClue['current']?.add(currentWord[i]);
      }
      else
        {
          letters.add(TextSpan(text: currentWord[i],style: const TextStyle(color: Colors.red)));

        }
    }
    Widget newClue = RichText(text:TextSpan(children: letters), );
    state = state.copyWith(clues: [...state.clues, newClue]);
  }

}

final textInputProvider =
StateNotifierProvider<TextInputNotifier, WordCheck>((ref) {
  return TextInputNotifier(
    wordCheck: WordCheck(
      userWords: [],
      actualWord: 'DRINK',
      currentWord: '',
      isMatched: false,
      isWordEntered: false,
      clues: [],
    ),
  );
});
