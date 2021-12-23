import 'package:bloc_login/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login/blocs/login/bloc/login_bloc.dart';
import 'package:bloc_login/blocs/login/bloc/login_event.dart';
import 'package:bloc_login/blocs/login/bloc/login_state.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          if (loginState.isFailure) {
            print('login failure');
          } else if (loginState.isSubmitting) {
            print("login submitting");
          } else if (loginState.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEventLoggedIn());
          }
          return Container(
            margin: EdgeInsets.only(top: 200),
            padding: EdgeInsets.all(20),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginEventEmailChanged(email: emailController.text));
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.email), labelText: 'Enter your email'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (_) {
                    return loginState.isValidEmail
                        ? null
                        : 'Invalid email format';
                  },
                ),
                TextFormField(
                    controller: passwordController,
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginEventPasswordChanged(
                              password: passwordController.text));
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Enter password'),
                    obscureText: true,
                    autocorrect: false,
                    validator: (_) {
                      return loginState.isValidEmail
                          ? null
                          : 'Invalid password format';
                    }),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginEventWithEmailAndPasswordPressed(
                            email: emailController.text,
                            password: passwordController.text));
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
