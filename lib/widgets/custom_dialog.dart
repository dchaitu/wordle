import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/provider/text_input_provider.dart';

class CustomDialog extends ConsumerWidget {
  final String title;
  final String subTitle;
  const CustomDialog({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title:  Text(title),
      content: Text(subTitle),
      actions: <Widget>[
        TextButton(
          child: const Text('Restart'),
          onPressed: () {
            // Navigator.of(context).pop();
            ref.read(textInputProvider.notifier).resetGameState(ref);
          },
        ),
      ],
    );
  }
}
