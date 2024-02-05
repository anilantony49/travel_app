import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textwidget(String text, VoidCallback onTap, [MaterialPageRoute? materialPageRoute]) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.alata(fontSize: 20)
        )),
  );
}
