import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wordle/provider/text_input_provider.dart';

Future<String> fetchWord() async {
  String wordUrl = 'http://127.0.0.1:8000/word/';
  final response = await http.get(Uri.parse(wordUrl));
  print("response: ${response.statusCode}");
  try {
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var word = jsonData['word'];
      print("word ${jsonData['word']}");
      return word;
    } else {
      return "Not received";
    }
  } catch (e) {
    return "Error $e";
  }
}


Widget showOldWords(WidgetRef ref) {
  List<String> userWords = ref.read(textInputProvider).userWords;
  if (userWords.isNotEmpty) {
    List<Widget> words = userWords.map((word) => Text(word)).toList();
    return Column(children: words);
  } else {
    return const SizedBox();
  }
}

Widget showClue(WidgetRef ref, String word) {
  List<TextSpan> letters = [];
  String actualWord = ref.read(textInputProvider).actualWord;
  for (int i = 0; i < actualWord.length; i++) {
    if (word[i] == actualWord[i]) {
      letters.add(TextSpan(
          text: word[i],
          style: const TextStyle(
              color: Colors.green, fontSize: 20, letterSpacing: 3)));
    } else if (actualWord.contains(word[i])) {
      letters.add(TextSpan(
          text: word[i],
          style: const TextStyle(
              color: Colors.orange, fontSize: 20, letterSpacing: 3)));
    } else {
      letters.add(TextSpan(
          text: word[i],
          style: const TextStyle(
              color: Colors.red, fontSize: 20, letterSpacing: 3)));
    }
  }

  Widget newClue = RichText(text: TextSpan(children: letters));
  return newClue;
}

Widget showAllClues(WidgetRef ref) {
  List<String> userWords = ref.read(textInputProvider).userWords;
  List<Widget> clues = [];
  for (String word in userWords) {
    clues.add(showClue(ref, word));
  }
  return Column(children: clues);
}

String showAnswer(WidgetRef ref) {
  int noOfChances = ref.watch(textInputProvider).noOfChances;
  String actualWord = ref.read(textInputProvider).actualWord;
  if (noOfChances < 1) {
    return "The Answer is $actualWord";
  } else {
    return "No of Chances remaining $noOfChances";
  }
}
