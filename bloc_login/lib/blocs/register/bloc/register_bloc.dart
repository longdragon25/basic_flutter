import 'package:bloc/bloc.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:bloc_login/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'register_state.dart';

part 'register_event.dart';
// part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    final registertate = state;
    if (event is RegisterEventEmailChanged) {
      yield registertate.cloneAndUpdate(
          isValidEmail: Validators.isValidEmail(event.email));
    } else if (event is RegisterEventPasswordChanged) {
      yield registertate.cloneAndUpdate(
          isValidPassword: Validators.isValidPassword(event.password));
    } else if (event is RegisterEventPressed) {
      yield RegisterState.loading();
      try {
        await userRepository.createUserWithEmailAndPassword(
            event.email, event.password);
        yield RegisterState.success();
      } catch (e) {
        print(e.toString());
        RegisterState.failure();
      }
    }
  }
}
