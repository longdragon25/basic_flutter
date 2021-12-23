import 'package:bloc/bloc.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationEventStarted) {
      final isSignedIn = await userRepository.isSignIn();
      if (isSignedIn) {
        final firebaseUser = await userRepository.getUser();
        yield AuthenticationSuccess(user: firebaseUser);
      } else {
        yield AuthenticationFailure();
      }
    } else if (event is AuthenticationEventLoggedIn) {
      yield AuthenticationSuccess(user: await userRepository.getUser());
    } else if (event is AuthenticationEventLoggedOut) {
      userRepository.signOut();
      yield AuthenticationFailure();
    }
  }
}
