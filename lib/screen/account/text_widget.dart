import 'package:flutter/material.dart';

Widget textwidget(String text, VoidCallback onTap, [MaterialPageRoute? materialPageRoute]) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        )),
  );
}
