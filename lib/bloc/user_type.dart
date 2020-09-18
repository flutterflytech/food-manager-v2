import 'dart:async';

// It provides user type to display relevant User Screen

class UserType {
  final stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get userSink => stateStreamController.sink;

  Stream<int> get userStream => stateStreamController.stream;

  void dispose() {
    stateStreamController.close();
  }
}
