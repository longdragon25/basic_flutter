import 'package:bloc_login/blocs/authentication/bloc/authentication_bloc.dart';

import 'package:bloc_login/blocs/register/bloc/register_bloc.dart';
import 'package:bloc_login/blocs/register/bloc/register_state.dart';
import 'package:bloc_login/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegisterScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(userRepository: userRepository),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            if (registerState.isFailure) {
              print('register failure');
            } else if (registerState.isSubmitting) {
              print("register submitting");
            } else if (registerState.isSuccess) {
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
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterEventEmailChanged(
                              email: emailController.text));
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: 'Enter your email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (_) {
                      return registerState.isValidEmail
                          ? null
                          : 'Invalid email format';
                    },
                  ),
                  TextFormField(
                      controller: passwordController,
                      onChanged: (value) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterEventPasswordChanged(
                                password: passwordController.text));
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock), labelText: 'Enter password'),
                      obscureText: true,
                      autocorrect: false,
                      validator: (_) {
                        return registerState.isValidEmail
                            ? null
                            : 'Invalid password format';
                      }),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterEventPressed(
                              email: emailController.text,
                              password: passwordController.text));
                      Navigator.of(context).pop();
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
                          "Register",
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
      ),
    );
  }
}
