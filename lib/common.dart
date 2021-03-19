library common;

import 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_inappwebview/flutter_inappwebview.dart';
export 'package:dio/dio.dart' show DioError, Dio, RequestOptions, Response;
export 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocBuilder, BlocListener, MultiBlocListener, MultiBlocProvider, MultiRepositoryProvider;
export 'package:json_annotation/json_annotation.dart';
export 'package:intl/intl.dart';
export 'package:rxdart/rxdart.dart';
export 'package:provider/provider.dart';
export 'package:share/share.dart';

var shared = SharedPreferences.getInstance();
