import 'dart:async';

class UserType {
  final stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get userSink => stateStreamController.sink;

  Stream<int> get userStream => stateStreamController.stream;

  void dispose() {
    stateStreamController.close();
  }
}
