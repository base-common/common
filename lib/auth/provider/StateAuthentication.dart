import 'package:common/common.dart';
import 'package:common/core/navigator_manager.dart';
import 'package:flutter/widgets.dart';

import 'StateAuth.dart';

class StateAuthentication extends StatefulWidget {
  final Widget child;
  final StateAuth state;
  final bool isAuth;
  final Widget home;
  final Widget auth;

  const StateAuthentication(
      {Key key,
      this.state,
      this.child,
      this.home,
      this.auth,
      this.isAuth = true})
      : super(key: key);

  @override
  _StateAuthenticationState createState() => _StateAuthenticationState();

  static _StateAuthenticationState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_StateDataAuthentication>())
        .data;
  }
}

class _StateAuthenticationState extends State<StateAuthentication> {
  StateAuth _state;

  StateAuth get getStateAuth => _state;

  @override
  void initState() {
    _state = widget.state;
    if (widget.isAuth)
      _state.widgetMain = widget.auth;
    else
      _state.widgetMain = widget.home;
    initUser();
    super.initState();
  }

  login({String token}) {
    if (token != null)
      NavigatorManager.navRoot.currentState.pushAndRemoveUntil(
          SlideLeftRoute(widget: widget.home), (route) => false);
    shared.then((shared) {
      shared.setString(StateAuth.KEY_SAVE_TOKEN, token).then((check) {
        if (check) {
          _state.widgetMain = widget.home;
          _state.token = token;
        }
      });
    });
  }

  logout() {
    _state.token = null;
    NavigatorManager.navRoot.currentState.pushAndRemoveUntil(
        SlideLeftRoute(widget: widget.auth), (route) => false);
    shared.then((shared) {
      shared.remove(StateAuth.KEY_SAVE_TOKEN);
      _state.widgetMain = widget.auth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _StateDataAuthentication(data: this, child: widget.child);
  }

  void initUser() {
    shared.then((shared) {
      var token = shared.getString(StateAuth.KEY_SAVE_TOKEN);
      if (token != null) {
        _state.token = token;
        _state.widgetMain = widget.home;
      }
    }).whenComplete(() {
      setState(() {});
    });
  }
}

class _StateDataAuthentication extends InheritedWidget {
  final _StateAuthenticationState data;

  _StateDataAuthentication({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataAuthentication old) => true;
}
