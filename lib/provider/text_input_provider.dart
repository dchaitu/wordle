import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class WordCheck {
  List<String> userWords;
  String actualWord;
  String currentWord;
  bool isMatched;
  bool isWordEntered;
  bool showClues;
  int noOfChances;
  bool isWon;

  WordCheck(
      {required this.userWords,
      required this.actualWord,
      required this.currentWord,
      required this.isMatched,
      required this.isWordEntered,
      required this.showClues,
      required this.noOfChances,
      required this.isWon
      });

  WordCheck copyWith(
      {List<String>? userWords,
      String? actualWord,
      String? currentWord,
      bool? isMatched,
      bool? isWordEntered,
      bool? showClues,
      int? noOfChances,
      bool? isWon}) {
    return WordCheck(
        userWords: userWords ?? this.userWords,
        actualWord: actualWord ?? this.actualWord,
        currentWord: currentWord ?? this.currentWord,
        isMatched: isMatched ?? this.isMatched,
        showClues: showClues ?? this.showClues,
        isWordEntered: isWordEntered ?? this.isWordEntered,
        noOfChances: noOfChances ?? this.noOfChances,
        isWon: isWon ?? this.isWon
    );
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
  void userWon(){
    state = state.copyWith(isWon: true);
  }

  void enterChar() {
    if (state.currentWord.length == 5) {
      if (state.actualWord == state.currentWord) {
        state = state.copyWith(
          isWordEntered: true,
          isMatched: true,
          userWords: [...state.userWords, state.currentWord],
          currentWord: '',
          noOfChances: state.noOfChances - 1,
          isWon: true,
        );
      } else {
        state = state.copyWith(
          isWordEntered: true,
          isMatched: false,
          userWords: [...state.userWords, state.currentWord],
          currentWord: '',
          showClues: true,
          noOfChances: state.noOfChances - 1,
        );
      }
    } else {
      print("Word is not completed");
      state = state.copyWith(isWordEntered: false);
    }
    controller.clear();
    state = state.copyWith(currentWord: '');
  }
}

final textInputProvider =
    StateNotifierProvider<TextInputNotifier, WordCheck>((ref) {
  final data = ref.watch(userDataProvider);

  return TextInputNotifier(
    wordCheck: WordCheck(
      userWords: [],
      actualWord: data.when(
          data: (data) => data,
          error: (error, s) => error.toString(),
          loading: () => "loading..."),
      currentWord: '',
      isWon: false,
      isMatched: false,
      isWordEntered: false,
      showClues: false,
      noOfChances: 6,
    ),
  );
});

class ApiService {
  String wordUrl = 'http://127.0.0.1:8000/word/';

  Future<String> getWord() async {
    final response = await http.get(Uri.parse(wordUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      var word = jsonData['word'];
      return word;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final userWordProvider = Provider<ApiService>((ref) => ApiService());

final userDataProvider = FutureProvider<String>((ref) async {
  return ref.watch(userWordProvider).getWord();
});
