import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

// Sets payment status if vendor approves from their end.

class PaymentStatus {
  final stateStreamController = StreamController<bool>.broadcast();

  StreamSink<bool> get choiceSink => stateStreamController.sink;

  Stream<bool> get choiceStream => stateStreamController.stream;

  paymentConformation(String bookingId) {
    Firestore.instance
        .collection('bookings')
        .document(bookingId)
        .updateData({'paymentStatus': true});
  }

  void dispose() {
    stateStreamController.close();
  }
}

// Add all due payments and streams for listener.

class DueBalance {
  final stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get dueSink => stateStreamController.sink;

  Stream<int> get dueStream => stateStreamController.stream;

  dueBalRes() {}

  void dispose() {
    stateStreamController.close();
  }
}
