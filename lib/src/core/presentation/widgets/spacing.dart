import 'package:flutter/material.dart';
import 'package:travel_tips_admin/src/core/presentation/constants.dart';

enum SpacingSize { base, tiny, small, regular, medium, large, xL }

double mapSpacingSizeToSize(SpacingSize size) {
  switch (size) {
    case SpacingSize.base:
      return Constants.baseMargin;
    case SpacingSize.tiny:
      return Constants.tinyMargin;
    case SpacingSize.small:
      return Constants.smallMargin;
    case SpacingSize.regular:
      return Constants.regularMargin;
    case SpacingSize.medium:
      return Constants.mediumMargin;
    case SpacingSize.large:
      return Constants.largeMargin;
    case SpacingSize.xL:
      return Constants.xLMargin;
  }
}

class Spacing extends StatelessWidget {
  const Spacing({
    super.key,
    this.isVertical = true,
    this.size = SpacingSize.base,
  });

  final bool isVertical;
  final SpacingSize size;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SizedBox(
        height: mapSpacingSizeToSize(size),
      );
    } else {
      return SizedBox(
        width: mapSpacingSizeToSize(size),
      );
    }
  }
}
