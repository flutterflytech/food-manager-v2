import 'dart:async';


class BookingStatus {
  final stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get bookingStatusSink => stateStreamController.sink;

  Stream<int> get bookingStatusStream => stateStreamController.stream;

  void dispose(){
    stateStreamController.close();
  }
}