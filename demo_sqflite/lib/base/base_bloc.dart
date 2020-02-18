import 'dart:async';

import 'package:demo_sqflite/base/base_event.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception('Do not be event!');
      }

      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event) {}

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
