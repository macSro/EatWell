import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecipeRating extends StatelessWidget {
  final double rating;

  RecipeRating({this.rating});

  @override
  Widget build(BuildContext context) {
    final emptyStar = const Icon(
      Icons.star_border_rounded,
      color: kTextColorSecondary,
      size: 16,
    );
    final halfStar = const Icon(
      Icons.star_half_rounded,
      color: Colors.amberAccent,
      size: 16,
    );
    final wholeStar = const Icon(
      Icons.star_rounded,
      color: Colors.amberAccent,
      size: 16,
    );
    return Column(
      children: [
        rating > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  rating < 1 ? halfStar : wholeStar,
                  rating > 1 && rating < 2
                      ? halfStar
                      : rating >= 2
                          ? wholeStar
                          : emptyStar,
                  rating > 2 && rating < 3
                      ? halfStar
                      : rating >= 3
                          ? wholeStar
                          : emptyStar,
                  rating > 3 && rating < 4
                      ? halfStar
                      : rating >= 4
                          ? wholeStar
                          : emptyStar,
                  rating > 4 && rating < 5
                      ? halfStar
                      : rating >= 5
                          ? wholeStar
                          : emptyStar,
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  emptyStar,
                  emptyStar,
                  emptyStar,
                  emptyStar,
                  emptyStar,
                ],
              ),
        const SizedBox(height: 2),
        Text(
          'Rating: ${rating > 0 ? rating : '-'}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
