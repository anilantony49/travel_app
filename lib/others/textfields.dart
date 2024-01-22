import 'package:flutter/material.dart';

Widget textfields(TextEditingController controller, String label, int? maxLines,
    TextInputType? keyboardType) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      controller: controller,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(color: Colors.black45),
        ),
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.3),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    ),
  );
}
