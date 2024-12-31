import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/provider/text_input_provider.dart';

class KeyboardWidget extends ConsumerWidget {
  // final TextEditingController controller;
  const KeyboardWidget({super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return allLetters(ref);
  }
}

Column allLetters(WidgetRef ref) {
  const List<String> allRows = ['QWERTYUIOP', 'ASDFGHJKL', 'ZXCVBNM','Enter Button', 'Back Button'];

  List<Row> keyboard = [];
  for (String row in allRows) {

    List<Widget> eachRow = [];
    if(row.contains('Enter Button')) {
      eachRow.add(
          keyBoardButton(row, ()=> ref.read(textInputProvider.notifier).enterChar())
      );
    }
    else if(row.contains('Back Button')) {
      eachRow.add(
          keyBoardButton(row, ()=> ref.read(textInputProvider.notifier).removeChar())
      );
    } else {
      for (var key in row.split('')) {
        eachRow.add(keyBoardButton(
            key, () =>ref.read(textInputProvider.notifier).addChar(key)));
      }
    }

    keyboard.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: eachRow,
    ));
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: keyboard,
  );
}

Widget keyBoardButton(String letter, VoidCallback onTap) {
  if(letter=='Enter Button') {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  } else if(letter=='Back Button')
    {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(4),
          child: const Icon(Icons.backspace_outlined),
        ),
      );

    }
  else {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(4),
        child: Text(
          letter,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
        ),
      ),
    );
  }
}
