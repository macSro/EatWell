import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/services/authorization.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String login;
  String password;
  String repeatPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
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
              hintText: 'Enter your e-mail',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) => val.isEmpty ? 'Enter login.' : null,
            onSaved: (val) => login = val,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter a login',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            validator: (val) => _validatePassword(val),
            onChanged: (val) => password = val,
            onSaved: (val) => password = val,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter a password',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            onSaved: (val) => repeatPassword = val,
            validator: (val) =>
                password != val ? 'Password doesn\'t match.' : null,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Repeat the password',
            ),
          ),
          const SizedBox(height: 32),
          RaisedButton(
            onPressed: () => _processRegister(context),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            color: kPrimaryColor,
            child: Text(
              'Sign Up',
              style: TextStyle().copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  String _validatePassword(String val) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    if (val.isEmpty)
      return 'Enter a password.';
    else if (val.length < 8)
      return 'Password must contain at least 8 characters.';
    else if (!regExp.hasMatch(val))
      return 'At least 1: uppercase, lowercase, special character & digit.';
    else
      return null;
  }

  _processRegister(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      dynamic authorizationResult =
          authorization.registerWithEmail(email, password);
      if (authorizationResult == null)
        print('failed');
      else {
        Navigator.pop(context);
      }
    }
  }
}
