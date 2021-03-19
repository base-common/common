part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> auth;

  AuthAuthenticated({@required this.auth});
}

class AuthNoAuthenticated extends AuthState {
  final String message;

  AuthNoAuthenticated({this.message});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({@required this.message});
}
