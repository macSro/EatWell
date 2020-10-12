import 'package:flutter/material.dart';

import '../../constants.dart';

class RecipeRatingButtons extends StatefulWidget {
  final recipeId;

  RecipeRatingButtons(this.recipeId);

  @override
  _RecipeRatingButtonsState createState() => _RecipeRatingButtonsState();
}

class _RecipeRatingButtonsState extends State<RecipeRatingButtons> {
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;
  bool isActive4 = false;
  bool isActive5 = false;
  int rating;

  @override
  Widget build(BuildContext context) {
    const emptyStar = Icon(
      Icons.star_border_rounded,
      color: kTextColorSecondary,
      size: 32,
    );
    const fullStar = Icon(
      Icons.star_rounded,
      color: Colors.amberAccent,
      size: 32,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: isActive1 ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (isActive1) {
                if (!isActive2) {
                  isActive1 = false;
                }
                isActive2 = false;
                isActive3 = false;
                isActive4 = false;
                isActive5 = false;
              } else {
                isActive1 = true;
              }
              rating = isActive1 ? 1 : 0;
              print('rating: $rating');
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: isActive2 ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (isActive2) {
                if (!isActive3) {
                  isActive1 = false;
                  isActive2 = false;
                }
                isActive3 = false;
                isActive4 = false;
                isActive5 = false;
              } else {
                isActive1 = true;
                isActive2 = true;
              }
              rating = isActive2 ? 2 : 0;
              print('rating: $rating');
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: isActive3 ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (isActive3) {
                if (!isActive4) {
                  isActive1 = false;
                  isActive2 = false;
                  isActive3 = false;
                }
                isActive4 = false;
                isActive5 = false;
              } else {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
              }
              rating = isActive3 ? 3 : 0;
              print('rating: $rating');
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: isActive4 ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (isActive4) {
                if (!isActive5) {
                  isActive1 = false;
                  isActive2 = false;
                  isActive3 = false;
                  isActive4 = false;
                }
                isActive5 = false;
              } else {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
                isActive4 = true;
              }
              rating = isActive4 ? 4 : 0;
              print('rating: $rating');
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: isActive5 ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (isActive5) {
                isActive1 = false;
                isActive2 = false;
                isActive3 = false;
                isActive4 = false;
                isActive5 = false;
              } else {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
                isActive4 = true;
                isActive5 = true;
              }
              rating = isActive5 ? 5 : 0;
              print('rating: $rating');
            });
          },
        ),
      ],
    );
  }

  _rateRecipe() {
    //TODO: if rating> 0 add RateRecipe event with [rating] and [widget.recipeId], check somehow if already rated to avoid multiple votes
  }
}
