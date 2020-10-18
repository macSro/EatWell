import 'package:eat_well_v1/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserRegisteredWithEmail extends UserState {
  final String email;
  final String password;

  UserRegisteredWithEmail({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated({this.user});

  @override
  List<Object> get props => [user];
}

class UserUnauthenticated extends UserState {
  @override
  List<Object> get props => [];
}
