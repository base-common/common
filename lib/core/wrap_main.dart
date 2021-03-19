import 'package:common/auth/bloc/auth_service.dart';
import 'package:common/bloc/auth/auth_bloc.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// File wrap_main
// @project learning
// @author minhhoang on 26-11-2020
class WrapMain extends StatelessWidget {
  final Widget child;
  final SharedPreferences sharedPreferences;

  const WrapMain({Key key,@required this.child,@required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthService>(
      create: (BuildContext context) {
        return AuthService(shared: sharedPreferences);
      },
      child: BlocProvider<AuthBloc>(
        create: (BuildContext context) {
          final authService = RepositoryProvider.of<AuthService>(context);
          return AuthBloc(authService)..add(AppLoaded());
        },
        child: child,
      ),
    );
  }
}
