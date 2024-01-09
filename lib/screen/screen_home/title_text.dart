  import 'package:flutter/material.dart';

Widget titleText(String text) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none,
                // letterSpacing: 1.5,
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
