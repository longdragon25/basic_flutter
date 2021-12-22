import 'package:bloc_login/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
