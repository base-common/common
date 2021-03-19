import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/auth/bloc/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading();
    final authMap = await authService.getAuth();
    if (event is AppLoaded) {
      if (authMap == null)
        yield AuthNoAuthenticated();
      else
        yield AuthAuthenticated(auth: authMap);
    }
    if (event is AuthLogin) {
      authService.setAuth(event.user);
      yield AuthAuthenticated(auth: event.user);
    }
    if (event is AuthLogout) {
      authService.removeAuth();
      yield AuthNoAuthenticated(message: event.message);
    }
  }
}
