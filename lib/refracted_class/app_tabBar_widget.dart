// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      // isScrollable: true,
      tabs: [
        Column(
          children: [
            Icon(Icons.info),
            Tab(text: 'About'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.payments),
            Tab(text: 'Key info'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.cloud),
            Tab(text: 'Weather'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.emergency),
            Tab(text: 'Emergency'),
          ],
        ),
      ],
    );
  }
}
