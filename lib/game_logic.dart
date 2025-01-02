import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
    } else
      return "Not recieved";
  } catch (e) {
    return "Error $e";
  }
}

String getResult(WidgetRef ref) {
  bool isWordEntered = ref.watch(textInputProvider).isWordEntered;
  bool isMatched = ref.watch(textInputProvider).isMatched;

  return (isMatched && isWordEntered) ? "Word Matched" : "Word Not Matched";
}


Widget showOldWords(WidgetRef ref){
  List<String> userWords = ref.read(textInputProvider).userWords;
  if(userWords.isNotEmpty)
    {
      List<Widget> words = userWords.map((word) => Text(word)).toList();
      return Column(children: words);
    }
  else{
    return const SizedBox();
  }
}

Widget showClues(WidgetRef ref)
{
  List<Object> clues = ref.read(textInputProvider).clues;

  Widget correctPositionClues = clues.map(clue["actual"]=> Text());
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