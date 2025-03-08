import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection(
      {super.key, this.itemSize = 18, this.alloTouchFunctionality = false});
  final double itemSize;
  final bool alloTouchFunctionality;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        RatingBar.builder(
          glowColor: Colors.purple,
          itemCount: 5,
          itemSize: itemSize,
          itemPadding: const EdgeInsets.only(right: 3),
          initialRating: 3.5,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          allowHalfRating: true,
          ignoreGestures: alloTouchFunctionality,
          onRatingUpdate: (_) {},
        ),
        Text(
          "(4500 Reviews)",
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
