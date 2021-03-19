part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppLoaded extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final Map<String, dynamic> auth;

  AuthLogin({@required this.auth});
}

class AuthLogout extends AuthEvent {
  final String message;

  AuthLogout({this.message});
}
