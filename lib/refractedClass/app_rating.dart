import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class Rating extends StatefulWidget {
  final double itemSize;
  double initialRating;
  Rating({
    super.key,
    required this.itemSize,
    required this.initialRating,
  });

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double initialRating = 0;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemPadding: const EdgeInsets.symmetric(
        horizontal: 1,
      ),
      direction: Axis.horizontal,
      itemCount: 5,
      minRating: 3,
      itemSize: widget.itemSize,
      initialRating: widget.initialRating,
      allowHalfRating: true,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
        full: const Icon(
          Icons.star,
          color: Color.fromARGB(255, 104, 63, 48),
        ),
        half: const Icon(
          Icons.star_half,
          color: Color.fromARGB(255, 104, 63, 48),
        ),
        empty: const Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 104, 63, 48),
        ),
      ),
      onRatingUpdate: (rating) {
        setState(() { // Update the `initialRating` property
          initialRating = rating;
        });
      },
    );
  }
}

