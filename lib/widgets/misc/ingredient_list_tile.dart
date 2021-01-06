import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../tools.dart';

class IngredientListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double amount;
  final String unit;
  final DateTime expDate;
  final Widget otherTrailing;
  final Function onTap;
  final Function onDelete;

  IngredientListTile({
    @required this.imageUrl,
    @required this.name,
    this.amount,
    this.unit,
    this.expDate,
    this.otherTrailing,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
        style: amount != null
            ? Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)
            : Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: expDate != null ? Text('Expires: ${Tools.getDate(expDate)}') : null,
      trailing: otherTrailing != null
          ? otherTrailing
          : onDelete == null
              ? amount != null
                  ? Text(
                      '${Tools.simplifyDouble(amount).toString()}${unit != null ? ' ' : ''}${unit != null ? Tools.getUnitShort(unit) : ''}',
                      style: TextStyle().copyWith(fontStyle: FontStyle.italic),
                    )
                  : null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (amount != null)
                      Text(
                        '${Tools.simplifyDouble(amount).toString()}${unit != null ? ' ' : ''}${unit != null ? Tools.getUnitShort(unit) : ''}',
                        style: TextStyle().copyWith(fontStyle: FontStyle.italic),
                      ),
                    IconButton(
                      icon: Icon(Icons.delete_rounded, color: Colors.redAccent),
                      onPressed: onDelete,
                    ),
                  ],
                ),
      visualDensity: VisualDensity(horizontal: 0, vertical: 4),
    );
  }
}
