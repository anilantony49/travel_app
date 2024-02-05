// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      // isScrollable: true,
      tabs: [
        Column(
          children: [
            const Icon(Icons.info),
            Tab(
              child: Text(
                'About',
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.payments),
            Tab(
                child: Text(
              'Key info',
              style: GoogleFonts.alata(
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.cloud),
            Tab(
              child: Text(
                'Weather',
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.emergency),
            Tab(
              child: Text(
                'Emergency',
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
