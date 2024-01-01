import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverGridDelegateWithFixedCrossAxisCountAndFixedWidth
    extends SliverGridDelegate {
  final double crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  SliverGridDelegateWithFixedCrossAxisCountAndFixedWidth({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double usableCrossAxisExtent =
        max(0.0, constraints.crossAxisExtent - crossAxisSpacing);
    final double childCrossAxisExtent =
        usableCrossAxisExtent / crossAxisCount - crossAxisSpacing;
    final double resolvedChildCrossAxisExtent =
        max(0.0, childCrossAxisExtent); // Ensure non-negative value

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount.floor(),
      childCrossAxisExtent: resolvedChildCrossAxisExtent,
      childMainAxisExtent: constraints.crossAxisExtent / crossAxisCount.floor(),
      crossAxisStride: resolvedChildCrossAxisExtent + crossAxisSpacing,
      mainAxisStride:
          constraints.crossAxisExtent / crossAxisCount.floor() + mainAxisSpacing,
      reverseCrossAxis:
          axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegate oldDelegate) {
    return false;
  }
}
