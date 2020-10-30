import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/bloc/user/user_event.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/service/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _repository;

  UserBloc() : super(UserInitial()) {
    _repository = UserRepository();
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is AppStarted)
      yield* _appStarted();
    else if (event is RegisterUserWithEmail)
      yield* _registerUserWithEmail(
        event.email,
        event.password,
        event.displayName,
      );
    else if (event is LoginUserWithEmail)
      yield* _loginUserWithEmail(
        event.email,
        event.password,
      );
    else if (event is SignOut) yield* _signOut();
  }

  Stream<UserState> _appStarted() async* {
    await Future.delayed(Duration(seconds: 2), () {});

    final firebaseUser = _repository.getCurrentUser();

    yield _repository.getCurrentUser() != null
        ? UserAuthenticated(
            userDisplayName:
                firebaseUser.displayName ?? kDefaultUserDisplayName)
        : UserUnauthenticated();
  }

  Stream<UserState> _registerUserWithEmail(
    email,
    password,
    displayName,
  ) async* {
    yield UserLoading();

    final authResult = await _repository.registerWithEmail(email, password);
    if (authResult != null) {
      yield UserRegisteredWithEmail();
    } else {
      yield UserRegistrationFailed();
    }
  }

  Stream<UserState> _loginUserWithEmail(email, password) async* {
    yield UserLoading();
    final authResult = await _repository.signInWithEmail(email, password);
    if (authResult != null)
      yield UserAuthenticated(
          userDisplayName:
              authResult.user.displayName ?? kDefaultUserDisplayName);
    else
      yield UserAuthenticationFailed();
  }

  Stream<UserState> _signOut() async* {
    yield UserLoading();
    //final authResult = await _repository.signOut();
    //if (authResult) {
    //  yield UserUnauthenticated();
    //} else {
    yield UserSignOutFailed();
    //yield UserAuthenticated(
    //    userDisplayName: _repository.getCurrentUser().displayName);
    //}
  }
}
