import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../constants.dart';
import '../../../tools.dart';
import '../../misc/icon_text.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  bool isError = false;
  bool isButtonPressed = false;
  bool focus1 = false;
  bool focus2 = false;
  bool focus3 = false;
  bool focus4 = false;

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {
        if (emailController.text.isNotEmpty) {
          focus1 = true;
        }
        focus2 = false;
        focus3 = false;
        focus4 = false;
      });
    });
    displayNameController.addListener(() {
      setState(() {
        if (displayNameController.text.isNotEmpty) {
          focus2 = true;
        }
        focus1 = false;
        focus3 = false;
        focus4 = false;
      });
    });
    passwordController.addListener(() {
      setState(() {
        if (passwordController.text.isNotEmpty) {
          focus3 = true;
        }
        focus1 = false;
        focus2 = false;
        focus4 = false;
      });
    });
    passwordRepeatController.addListener(() {
      setState(() {
        if (passwordRepeatController.text.isNotEmpty) {
          focus4 = true;
        }
        focus1 = false;
        focus2 = false;
        focus3 = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        isButtonPressed = false;
        if (isError) {
          _formKey.currentState.validate();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = Tools.validateEmail(val);
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail_outline_rounded),
              hintText: 'Enter your e-mail',
              suffixIcon: focus1
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus1 = false;
                        });
                        emailController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: displayNameController,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = val.isEmpty ? 'Enter a display name.' : null;
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter a display name',
              suffixIcon: focus2
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus2 = false;
                        });
                        displayNameController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = Tools.validatePassword(val);
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter a password',
              suffixIcon: focus3
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus3 = false;
                        });
                        passwordController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordRepeatController,
            obscureText: true,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = val.isEmpty
                  ? 'Repeat the password.'
                  : passwordController.text != val
                      ? 'Password doesn\'t match.'
                      : null;
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Repeat the password',
              suffixIcon: focus4
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus4 = false;
                        });
                        passwordRepeatController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          RaisedButton(
            onPressed: () => _processRegister(context),
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: IconText(
              iconFirst: false,
              squeeze: true,
              icon: Icon(
                Icons.check_rounded,
                size: 28,
              ),
              text: Text(
                'Sign Up',
                style: TextStyle().copyWith(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _processRegister(context) {
    isButtonPressed = true;
    if (_formKey.currentState.validate()) {
      BlocProvider.of<UserBloc>(context).add(
        RegisterWithEmail(
          email: emailController.text,
          password: passwordController.text,
          displayName: displayNameController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    displayNameController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    super.dispose();
  }
}
