import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final Icon icon;
  final Text title;
  final Function onTap;

  MyDrawerTile(
      {@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: title,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
