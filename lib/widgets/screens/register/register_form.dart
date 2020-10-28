import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/services/authorization.dart';
import 'package:eat_well_v1/tools.dart';
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
            validator: (val) => Tools.validateEmail(val),
            onSaved: (val) => email = val,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.mail_outline_rounded),
              hintText: 'Enter your e-mail',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //TODO: low priority: validator should always return null so that displayName is not required and there should be a screen to change user settings
            validator: (val) => val.isEmpty ? 'Enter a display name.' : null,
            onSaved: (val) => login = val,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter a display name',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            validator: (val) => Tools.validatePassword(val),
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
          const SizedBox(height: 16),
          RaisedButton(
            onPressed: () => _processRegister(context),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
