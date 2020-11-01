import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/bloc/user/user_event.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
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
    else if (event is RegisterWithEmail)
      yield* _registerWithEmail(
        event.email,
        event.password,
        event.displayName,
      );
    else if (event is SignInWithEmail)
      yield* _signInWithEmail(
        event.email,
        event.password,
      );
    else if (event is SignInWithGoogle)
      yield* _signInWithGoogle();
    else if (event is SignOut) yield* _signOut();
  }

  Stream<UserState> _appStarted() async* {
    await Future.delayed(Duration(seconds: 2), () {});

    final firebaseUser = _repository.getCurrentUser();

    yield _repository.getCurrentUser() != null
        ? UserAuthenticated(userDisplayName: firebaseUser.displayName)
        : UserUnauthenticated();
  }

  Stream<UserState> _registerWithEmail(
    email,
    password,
    displayName,
  ) async* {
    yield UserLoading();

    final authResult = await _repository.registerWithEmail(email, password);
    if (authResult != null) {
      await _repository.updateUserProfile(displayName: displayName);
      yield UserRegisteredWithEmail();
    } else {
      yield UserRegistrationFailed();
    }
  }

  Stream<UserState> _signInWithEmail(email, password) async* {
    yield UserLoading();
    final authResult = await _repository.signInWithEmail(email, password);
    if (authResult != null)
      yield UserAuthenticated(userDisplayName: authResult.user.displayName);
    else
      yield UserAuthenticationFailed();
  }

  Stream<UserState> _signInWithGoogle() async* {
    yield UserLoading();
    final googleAccountDisplayName = await _repository.signInWithGoogle();
    if (googleAccountDisplayName != null) {
      await _repository.updateUserProfile(
          displayName: googleAccountDisplayName);
      yield UserAuthenticated(userDisplayName: googleAccountDisplayName);
    } else
      yield UserAuthenticationFailed();
  }

  Stream<UserState> _signOut() async* {
    yield UserLoading();
    final authResult = await _repository.signOut();
    if (authResult) {
      print('sign out success');
      yield UserUnauthenticated();
    } else {
      yield UserSignOutFailed();
      yield UserAuthenticated(
          userDisplayName: _repository.getCurrentUser().displayName);
    }
  }
}
