import 'package:eat_well_v1/widgets/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../constants.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/registerBackground.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 34,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/xo.svg',
                  height: 72,
                ),
                const SizedBox(height: 32),
                Text(
                  'Set up your account!',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kPrimaryColorDark),
                ),
                const SizedBox(height: 32),
                KeyboardAvoider(
                  child: RegisterForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //TODO: form wyciagnac jako osobny stful widget i zrobic dispose
}
