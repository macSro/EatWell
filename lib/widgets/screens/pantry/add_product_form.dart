import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:flutter/material.dart';

class AddProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Enter a product',
          ),
        ),
        const SizedBox(height: 8),
        RaisedButton(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          onPressed: () {},
          child: Text(
            'Search',
            style: TextStyle().copyWith(fontSize: 18),
          ),
          color: kPrimaryColorDark,
        ),
        const SizedBox(height: 16),
        const Divider(),
        //TODO: wrap with blocbuilder and sho/hide based on results.length
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 2,
        //     itemBuilder: (BuildContext context, int index) => IngredientListTile(
        //       imageUrl: 'https://spoonacular.com/cdn/ingredients_100x100/apple.jpg',
        //       name: 'apple',
        //     ),
        //   ),
        // ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oops, no results!',
                style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(height: 32),
              Text(
                'Please check the search phrase or report a missing product. We will update the product list ASAP.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 32),
              RaisedButton(
                color: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                onPressed: () {},
                child: IconText(
                  text: Text(
                    'Report!',
                    style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                  ),
                  icon: Icon(Icons.warning_rounded),
                  squeeze: true,
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 16),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(
        //       width: 120,
        //       child: TextFormField(
        //         decoration: InputDecoration(
        //           hintText: 'Amount',
        //           contentPadding: const EdgeInsets.only(left: 12, right: 12),
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 16),
        //     SizedBox(
        //       width: 120,
        //       child: DropdownButtonFormField(
        //         decoration: InputDecoration(
        //           contentPadding: const EdgeInsets.only(left: 12, right: 6),
        //         ),
        //         icon: Icon(Icons.arrow_downward_rounded, size: 20),
        //         value: 'g',
        //         items: ['g', 'oz', 'serving', 'clove']
        //             .map(
        //               (String value) => DropdownMenuItem(
        //                 value: value,
        //                 child: Text(value),
        //               ),
        //             )
        //             .toList(),
        //         onChanged: (value) {},
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 16),
        // RaisedButton(
        //   color: kPrimaryColor,
        //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        //   onPressed: () {},
        //   child: IconText(
        //     text: Text(
        //       'Add',
        //       style: TextStyle().copyWith(fontSize: 28),
        //     ),
        //     icon: Icon(
        //       Icons.kitchen_rounded,
        //       size: 28,
        //     ),
        //     squeeze: true,
        //   ),
        // ),
        const SizedBox(height: 16),
        //Spacer(),
        const Divider(),
      ],
    );
  }
}
