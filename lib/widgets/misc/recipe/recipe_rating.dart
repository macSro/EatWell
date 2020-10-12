import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:flutter/material.dart';

class RecipeRating extends StatelessWidget {
  final Rating rating;

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
        rating.votes != 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  rating.rating < 1 ? halfStar : wholeStar,
                  rating.rating > 1 && rating.rating < 2
                      ? halfStar
                      : rating.rating >= 2
                          ? wholeStar
                          : emptyStar,
                  rating.rating > 2 && rating.rating < 3
                      ? halfStar
                      : rating.rating >= 3
                          ? wholeStar
                          : emptyStar,
                  rating.rating > 3 && rating.rating < 4
                      ? halfStar
                      : rating.rating >= 4
                          ? wholeStar
                          : emptyStar,
                  rating.rating > 4 && rating.rating < 5
                      ? halfStar
                      : rating.rating >= 5
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
        SizedBox(height: 2),
        Text(
          'Rating: ${rating.votes > 0 ? rating.rating : 'No ratings'}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
