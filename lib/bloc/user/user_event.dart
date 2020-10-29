import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserEvent extends Equatable {}

class AppStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

class RegisterUserWithEmail extends UserEvent {
  final String email;
  final String password;

  RegisterUserWithEmail({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginUserWithEmail extends UserEvent {
  final String email;
  final String password;

  LoginUserWithEmail({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginUserWithGoogle extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
