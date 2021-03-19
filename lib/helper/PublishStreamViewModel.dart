import 'dart:async';

class PublishStreamViewModel<T> {
  var _streamController = StreamController<T>.broadcast();

  bool get isClosed => _streamController.isClosed;

  Sink get inputStream => _streamController.sink;

  Stream<T> get outputStream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}
