import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class RegisterUserWithEmail extends UserEvent {
  final String email;
  final String password;

  RegisterUserWithEmail({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginUserWithEmail extends UserEvent {
  final String email;
  final String password;

  LoginUserWithEmail({this.email, this.password});

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
