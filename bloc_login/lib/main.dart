import 'package:bloc_login/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login/blocs/login/bloc/login_bloc.dart';
import 'package:bloc_login/blocs/simple_bloc_observer.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:bloc_login/screens/home_screen.dart';
import 'package:bloc_login/screens/login_screen.dart';
import 'package:bloc_login/screens/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final userRepository = UserRepository();
    // userRepository.createUserWithEmailAndPassword(
    //     "longdragon@gmail.com", "123456");
    return MaterialApp(
        title: 'Login with Firebase',
        home: BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AuthenticationEventStarted()),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                print(state);
                if (state is AuthenticationSuccess) {
                  return HomeScreen(
                    user: state.user,
                  );
                } else if (state is AuthenticationFailure) {
                  return BlocProvider<LoginBloc>(
                    create: (context) =>
                        LoginBloc(userRepository: _userRepository),
                    child: LoginScreen(
                      userRepository: _userRepository,
                    ),
                  );
                }
                return SplashScreen();
              },
            )));
  }
}
