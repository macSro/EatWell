import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../constants.dart';
import '../../../model/recipe.dart';

class RecipeRatingButtons extends StatefulWidget {
  final Recipe recipe;
  final int userRating;

  RecipeRatingButtons({this.recipe, this.userRating});

  @override
  _RecipeRatingButtonsState createState() => _RecipeRatingButtonsState();
}

class _RecipeRatingButtonsState extends State<RecipeRatingButtons> {
  List<bool> activeStars = List.filled(5, false);

  @override
  void initState() {
    _fillInStars(1, widget.userRating, true);
    super.initState();
  }

  _fillInStars(int start, int end, bool fill) {
    for (int i = start - 1; i < end; i++) {
      activeStars[i] = fill;
    }
  }

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
          child: activeStars[0] ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (activeStars[0]) {
                if (!activeStars[1]) {
                  activeStars[0] = false;
                }
                _fillInStars(2, 5, false);
              } else {
                activeStars[0] = true;
              }
              _rateRecipe(context, activeStars[0] ? 1 : 0);
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: activeStars[1] ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (activeStars[1]) {
                if (!activeStars[2]) {
                  _fillInStars(1, 2, false);
                }
                _fillInStars(3, 5, false);
              } else {
                _fillInStars(1, 2, true);
              }
              _rateRecipe(context, activeStars[1] ? 2 : 0);
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: activeStars[2] ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (activeStars[2]) {
                if (!activeStars[3]) {
                  _fillInStars(1, 3, false);
                }
                _fillInStars(4, 5, false);
              } else {
                _fillInStars(1, 3, true);
              }
              _rateRecipe(context, activeStars[2] ? 3 : 0);
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: activeStars[3] ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (activeStars[3]) {
                if (!activeStars[4]) {
                  _fillInStars(1, 4, false);
                }
                activeStars[4] = false;
              } else {
                _fillInStars(1, 4, true);
              }
              _rateRecipe(context, activeStars[3] ? 4 : 0);
            });
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          child: activeStars[4] ? fullStar : emptyStar,
          onTap: () {
            setState(() {
              if (activeStars[4]) {
                _fillInStars(1, 5, false);
              } else {
                _fillInStars(1, 5, true);
              }
              _rateRecipe(context, activeStars[4] ? 5 : 0);
            });
          },
        ),
      ],
    );
  }

  _rateRecipe(context, rating) {
    BlocProvider.of<RecipeBloc>(context).add(UpdateRecipeRating(
      recipe: widget.recipe,
      rating: rating,
    ));
  }
}
