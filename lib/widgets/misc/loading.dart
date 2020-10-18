import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';

import '../../constants.dart';

class LoadingView extends StatelessWidget {
  final text;

  LoadingView({this.text = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loading(
            indicator: BallScaleMultipleIndicator(),
            color: kPrimaryColor,
            size: 80,
          ),
          //const SizedBox(height: 16),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
