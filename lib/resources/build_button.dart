import 'package:flutter/material.dart';

TextButton buildButton(Color colorButton, Color clickColorButton, String text, Function()? onPressed) {
  return TextButton(
      style: TextButton.styleFrom(primary: clickColorButton, backgroundColor: colorButton),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed
  );
}