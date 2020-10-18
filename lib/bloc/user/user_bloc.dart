import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/bloc/user/user_event.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/model/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is RegisterUserWithEmail)
      yield* _registerUserWithEmail(event.email, event.password);
    else if (event is LoginUserWithEmail)
      yield* _loginUserWithEmail(event.email, event.password);
  }

  Stream<UserState> _registerUserWithEmail(email, password) async* {
    yield UserLoading();
    //TODO: FIREBASE
    yield UserRegisteredWithEmail(email: email, password: password);

    //TODO: error
  }

  Stream<UserState> _loginUserWithEmail(email, password) async* {
    yield UserLoading();
    //TODO: FIREBASE
    final user = await Future.delayed(
      Duration(seconds: 2),
      () {
        final user = User(
          id: '1',
          displayName: 'pziomek111',
        );
        return user;
      },
    );
    yield UserAuthenticated(user: user);

    //TODO: error and yield UserUnauthenticated
  }
}
