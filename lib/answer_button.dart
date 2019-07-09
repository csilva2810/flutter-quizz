import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  AnswerButton({this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      borderSide: BorderSide(color: color),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: color),
      ),
      onPressed: onPressed,
    );
  }
}
