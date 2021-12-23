import 'package:bloc_login/blocs/login/bloc/login_event.dart';
import 'package:bloc_login/blocs/login/bloc/login_state.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:bloc_login/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    final loginState = state;
    if (event is LoginEventEmailChanged) {
      yield loginState.cloneAndUpdate(
          isValidEmail: Validators.isValidEmail(event.email!));
    } else if (event is LoginEventPasswordChanged) {
      yield loginState.cloneAndUpdate(
          isValidPassword: Validators.isValidPassword(event.password!));
    } else if (event is LoginEventWithGooglePressed) {
      try {
        await userRepository.signInWithGoogle();
        yield LoginState.success();
      } catch (_) {
        yield LoginState.failure();
      }
    } else if (event is LoginEventWithEmailAndPasswordPressed) {
      try {
        await userRepository.signInWithEmailAndPassword(
            event.email!, event.password!);
        yield LoginState.success();
      } catch (_) {
        yield LoginState.failure();
      }
    }
  }
}
