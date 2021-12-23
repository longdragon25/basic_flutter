part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User? user;

  AuthenticationSuccess({required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user!];

  @override
  String toString() => 'AuthenticationSuccess, email: ${user!.email}';
}

class AuthenticationFailure extends AuthenticationState {}
