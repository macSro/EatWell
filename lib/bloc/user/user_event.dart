abstract class UserEvent {}

class RegisterUser implements UserEvent {
  final String email;
  final String password;

  RegisterUser({this.email, this.password});
}

class LoginUserWithEmail implements UserEvent {
  final String email;
  final String password;

  LoginUserWithEmail({this.email, this.password});
}

class LoginUserWithGoogle implements UserEvent {}

class SignOut implements UserEvent {}

class GainPoints implements UserEvent {
  final int points;
  GainPoints(this.points);
}
