import 'package:flutter/material.dart';

import '../../../constants.dart';

class MyDrawerTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  MyDrawerTile(
      {@required this.iconData, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: kAccentColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
