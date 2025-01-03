import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/provider/text_input_provider.dart';
import 'package:wordle/widgets/color_utils.dart';

class KeyboardWidget extends ConsumerWidget {
  const KeyboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return allLetters(ref);
  }
}

Widget allLetters(WidgetRef ref) {
  const List<String> allRows = [
    'Q W E R T Y U I O P',
    'A S D F G H J K L',
    'Enter Z X C V B N M Back',
  ];

  List<Row> keyboard = [];
  for (String row in allRows) {
    List<Widget> eachRow = [];

    for (var key in row.split(' ')) {
      if (key.contains('Enter')) {
        eachRow.add(keyBoardButton(
            key, () => ref.read(textInputProvider.notifier).enterChar()));
      } else if (key.contains('Back')) {
        eachRow.add(keyBoardButton(
            key, () => ref.read(textInputProvider.notifier).removeChar()));
      } else
        eachRow.add(keyBoardButton(
            key, () => ref.read(textInputProvider.notifier).addChar(key)));
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

Widget keyWidget(String letter, VoidCallback onTap, Widget childWidget) {
  final buttonColor = HexColor('#818384');
  const double marginSpace = 4.0;
  const double circularRadius = 8;

  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius),
        color: buttonColor,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(marginSpace),
      child: Center(child: childWidget),
    ),
  );
}

Widget keyBoardButton(String letter, VoidCallback onTap) {

  if (letter == 'Enter') {
    return keyWidget(letter, onTap, const Icon(Icons.arrow_forward_ios));

  } else if (letter == 'Back') {

    return keyWidget(letter, onTap, const Icon(Icons.backspace_outlined));
  } else {
    return keyWidget(
      letter, onTap, Text(
        letter,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );


  }
}
