import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_state.dart';
import '../../../constants.dart';
import '../../misc/loading.dart';
import '../error_screen.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            previous is UserLoading && current is UserRegisteredWithEmail,
        listener: (context, state) => Navigator.pop(context),
        child: BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              previous is UserLoading && current is UserRegistrationFailed,
          listener: (context, state) => Navigator.pushNamed(
            context,
            ErrorScreen.routeName,
            arguments: kUserRegisterFailedMessage,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state is UserLoading
                ? LoadingView(text: 'Creating your account...')
                : _getContent(context),
          ),
        ),
      ),
    );
  }

  Widget _getContent(context) {
    return Stack(
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
              icon: Icon(Icons.arrow_back_rounded),
              iconSize: 34,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
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
                height: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Set up your account!',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              KeyboardAvoider(child: RegisterForm()),
            ],
          ),
        ),
      ],
    );
  }
}
