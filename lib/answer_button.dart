import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
    this.isTextField = false,
    this.textController,
  });

  final String answerText;
  final void Function() onTap;
  final bool isTextField;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    if (isTextField) {
      return TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: answerText,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onTap,
        child: Text(answerText),
      );
    }
  }
}
