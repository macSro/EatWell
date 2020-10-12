import 'package:eat_well_v1/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/loading.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 128,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                        strokeWidth: 4,
                      )),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
