import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/recipe/recipe_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RecipeListItem extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final int readyInMinutes;
  final int servings;
  final Rating rating;
  final Function onTap;
  final Widget bottom;

  RecipeListItem({
    @required this.id,
    @required this.name,
    this.imageUrl,
    this.readyInMinutes,
    this.servings,
    this.rating,
    @required this.onTap,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _getTitledImage(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: _getDetailsBar(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bottom,
            ),
            SizedBox(height: bottom != null ? 10 : 0),
          ],
        ),
      ),
    );
  }

  Widget _getTitledImage(context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fadeInDuration: const Duration(milliseconds: 250),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: kPrimaryColor.withOpacity(0.65),
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getDetailsBar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconText(
          text: Text(
            '$readyInMinutes min',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          icon: Icon(
            Icons.timer_rounded,
            color: kPrimaryColorDark,
          ),
        ),
        RecipeRating(rating: rating),
        IconText(
          text: Text(
            '$servings pers',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          icon: Icon(
            Icons.group_rounded,
            color: kPrimaryColorDark,
          ),
          iconFirst: false,
        ),
      ],
    );
  }
}
