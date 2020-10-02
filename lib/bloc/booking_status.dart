// Booking Status to show ScanResult PopUp dialog. It returns an Integer value into Stream for the listener.

import 'dart:async';

class BookingStatus {
  final stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get bookingStatusSink => stateStreamController.sink;

  Stream<int> get bookingStatusStream => stateStreamController.stream;

  void dispose() {
    stateStreamController.close();
  }
}
