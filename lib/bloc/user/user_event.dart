import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserEvent extends Equatable {}

class AppStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

class RegisterWithEmail extends UserEvent {
  final String email;
  final String password;
  final String displayName;

  RegisterWithEmail({
    @required this.email,
    @required this.password,
    @required this.displayName,
  });

  @override
  List<Object> get props => [email, password, displayName];
}

class SignInWithEmail extends UserEvent {
  final String email;
  final String password;

  SignInWithEmail({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogle extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
