import 'dart:convert';

import 'package:http/http.dart' as http;


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
  }
  catch (e) {
    return "Error $e";
  }

}
