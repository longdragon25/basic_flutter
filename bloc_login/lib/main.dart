import 'package:bloc_login/blocs/simple_bloc_observer.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final userRepository = UserRepository();
    // userRepository.createUserWithEmailAndPassword(
    //     "longdragon@gmail.com", "123456");
    return MaterialApp(
        title: 'Login with Firebase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: Text("aloalo"),
          ),
        ));
  }
}
