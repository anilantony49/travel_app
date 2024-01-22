import 'package:flutter/material.dart';

class BackgroundColor extends StatelessWidget {
  final Widget child;

  const BackgroundColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 41, 199, 201),
            Color(0xFFE4EfE9),
          ], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
