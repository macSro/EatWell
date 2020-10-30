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
  @override
  List<Object> get props => [];
}

class UserRegistrationFailed extends UserState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends UserState {
  final String userDisplayName;

  UserAuthenticated({this.userDisplayName});

  @override
  List<Object> get props => [userDisplayName];
}

class UserUnauthenticated extends UserState {
  @override
  List<Object> get props => [];
}

class UserAuthenticationFailed extends UserState {
  @override
  List<Object> get props => [];
}

class UserSignOutFailed extends UserState {
  @override
  List<Object> get props => [];
}
