import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String AUTH = "auth";
  SharedPreferences sharedPreferences;
  static final AuthService _singleton = AuthService._internal();

  AuthService._internal();

  factory AuthService({SharedPreferences shared}) {
    if (_singleton.sharedPreferences == null) _singleton.sharedPreferences = shared;
    return _singleton;
  }

  setAuth(Map<String, dynamic> auth) async {
    sharedPreferences.setString(AUTH, jsonEncode(auth));
  }

  Future<Map<String, dynamic>> getAuth() async {
    final auth = sharedPreferences.getString(AUTH);
    return Future.value(auth == null ? auth : jsonDecode(auth));
  }

  removeAuth() async {
    sharedPreferences.remove(AUTH);
    CookieManager.instance().deleteAllCookies();
  }
}
