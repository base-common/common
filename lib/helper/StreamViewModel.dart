import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class StreamViewModel<T> {
  var _streamController = BehaviorSubject<T>();

  bool get isClosed => _streamController.isClosed;

  Sink get inputStream => _streamController.sink;

  Stream<T> get outputStream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}
