part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppLoaded extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final Map<String, dynamic> user;

  AuthLogin({@required this.user});
}

class AuthLogout extends AuthEvent {
  final String message;

  AuthLogout({this.message});
}
