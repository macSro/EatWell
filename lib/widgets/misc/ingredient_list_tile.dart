import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../tools.dart';
import 'circle_icon_button.dart';

class IngredientListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double amount;
  final String unit;
  final DateTime expDate;

  IngredientListTile({
    @required this.imageUrl,
    @required this.name,
    this.amount,
    this.unit,
    this.expDate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 48,
        width: 48,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(child: Image.network(imageUrl)),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: kAccentColor,
            width: 2,
          ),
        ),
      ),
      title: Text(
        Tools.capitalizeFirstWord(name),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: expDate != null ? Text('Exp: ${expDate.day}-${expDate.month}-${expDate.year}') : null,
      trailing: amount != null ? Text(
        '${Tools.simplifyDouble(amount).toString()}${unit != null ? ' ' : ''}${unit != null ? Tools.getUnitShort(unit) : ''}',
        style: TextStyle().copyWith(fontStyle: FontStyle.italic),
      ) : null,
      visualDensity: VisualDensity(horizontal: 0, vertical: 4),
    );
  }
}
