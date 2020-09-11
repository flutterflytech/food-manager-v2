import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentStatus{
  final  stateStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get choiceSink => stateStreamController.sink;

  Stream<bool> get choiceStream => stateStreamController.stream;

  paymentConformation(String bookingId){

    Firestore.instance.collection('bookings').document(bookingId).updateData({
      'paymentStatus': true
    });

  }

  void dispose(){
    stateStreamController.close();
  }
}