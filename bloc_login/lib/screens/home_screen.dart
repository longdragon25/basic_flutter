import 'package:bloc_login/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationEventLoggedOut());
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
