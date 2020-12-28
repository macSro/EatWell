import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../misc/icon_text.dart';

class CreateRecipeForm extends StatefulWidget {
  @override
  _CreateRecipeFormState createState() => _CreateRecipeFormState();
}

class _CreateRecipeFormState extends State<CreateRecipeForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          minLines: 1,
          maxLines: 5,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            prefixIcon: const Icon(Icons.title_rounded),
            labelText: 'Recipe name',
          ),
        ),
        const SizedBox(height: 16),
        RaisedButton(
          onPressed: () => {},
          color: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: IconText(
            iconFirst: false,
            squeeze: true,
            icon: Icon(
              Icons.arrow_forward_rounded,
              size: 28,
            ),
            text: Text(
              'Select the meal type',
              style: TextStyle().copyWith(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        RaisedButton(
          onPressed: () => {},
          color: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: IconText(
            iconFirst: false,
            squeeze: true,
            icon: Icon(
              Icons.arrow_forward_rounded,
              size: 28,
            ),
            text: Text(
              'Select the cuisine',
              style: TextStyle().copyWith(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        RaisedButton(
          onPressed: () => {},
          color: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: IconText(
            iconFirst: false,
            squeeze: true,
            icon: Icon(
              Icons.arrow_forward_rounded,
              size: 28,
            ),
            text: Text(
              'Select the diet',
              style: TextStyle().copyWith(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
