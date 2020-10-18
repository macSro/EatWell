import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_event.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final String emailFill;
  final String passwordFill;

  LoginForm({this.emailFill, this.passwordFill});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) => val.isEmpty ||
                    !val.contains('@') ||
                    val.startsWith('@') ||
                    val.endsWith('@')
                ? 'Enter a valid e-mail.'
                : null,
            onSaved: (val) => email = val,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.mail_outline_rounded),
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) => val.isEmpty ? 'Enter a password.' : null,
            onSaved: (val) => password = val,
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 16),
          RaisedButton(
            onPressed: () => _processLogin(context),
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              'Sign In',
              style: TextStyle().copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          RaisedButton(
            onPressed: () => _navigateToRegisterScreen(context),
            color: kPrimaryColorDark,
            child: Text(
              'Sign Up',
              style: TextStyle().copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  _navigateToRegisterScreen(context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  _processLogin(context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<UserBloc>(context)
          .add(LoginUserWithEmail(email: email, password: password));
    }
  }
}
