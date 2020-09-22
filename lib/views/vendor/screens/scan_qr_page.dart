import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/bloc/booking_status.dart';
import 'package:food_manager_v2/main.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:food_manager_v2/utils/firebase_utils.dart';

class ScanQr extends StatefulWidget {
  final String user;
  final String userFName;
  final String userSurname;

  const ScanQr({Key key, this.user, this.userFName, this.userSurname})
      : super(key: key);

  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  BookingStatus bookingStatus = BookingStatus();
  List<dynamic> bookingList = List();
  List<dynamic> userList = List();
  String qrCode;
  bool paymentStatus = false;
  int statusBooking;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    Map map = jsonDecode(barcodeScanRes);
    Record record = Record.fromJson(map);

    DocumentReference documentReference =
        Firestore.instance.collection('account').document(record.uid);
    var a = await documentReference.get();
    List list = a["recentBookings"] as List;

    if (a["lastBookingDate"] == getCurrentFireBaseServerDate() ||
        a["lastBookingDate"] == null) {
      if (list.contains(record.mealType)) {
        print('Booking Error ');

        bookingStatus.bookingStatusSink.add(statusBooking = 1);
        openDialog(context);
      } else {
        list.add(record.mealType);
        documentReference.updateData({
          "lastBookingDate": getCurrentFireBaseServerDate(),
          "recentBookings": list,
        });
        setState(() {
          DocumentReference docRef =
              Firestore.instance.collection('bookings').document();
          docRef.setData({
            "bookingId": docRef.documentID,
            "timeStamp": getCurrentFireBaseServerDate(),
            "userId": record.uid,
            "vendorId": widget.user,
            "userFName": record.userFName,
            "vendorFName": widget.userFName,
            "userLName": record.userSurname,
            "vendorLName": widget.userSurname,
            "mealType": record.mealType,
            "mealPrice": priceList[record.mealType].price,
            "mealName": priceList[record.mealType].foodName,
            "paymentStatus": paymentStatus,
          });
          bookingStatus.bookingStatusSink.add(statusBooking = 0);
          openDialog(context);
        });
      }
    } else {
      documentReference.updateData({
        "lastBookingDate": getCurrentFireBaseServerDate(),
        "recentBookings": [record.mealType],
      });
      setState(() {
        DocumentReference docRef =
            Firestore.instance.collection('bookings').document();
        docRef.setData({
          "bookingId": docRef.documentID,
          "timeStamp": getCurrentFireBaseServerDate(),
          "userId": record.uid,
          "vendorId": widget.user,
          "userFName": record.userFName,
          "vendorFName": widget.userFName,
          "userLName": record.userSurname,
          "vendorLName": widget.userSurname,
          "mealType": record.mealType,
          "mealPrice": priceList[record.mealType].price,
          "mealName": priceList[record.mealType].foodName,
          "paymentStatus": paymentStatus,
        });
        bookingStatus.bookingStatusSink.add(statusBooking = 0);
        openDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.width * 1.0,
                width: MediaQuery.of(context).size.width * 1.0,
                child: FlareActor(
                  "assets/flare/scan_qr.flr",
                  animation: "scan",
                  fit: BoxFit.cover,
                  color: Colors.blue[900],
                )),
            StreamBuilder<int>(
                stream: bookingStatus.bookingStatusStream,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      scanBarcodeNormal();
                    },
                    child: Container(
                        width: 170,
                        height: 80,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.blue[100],
                                    Colors.blue[900],
                                    Colors.blue[100]
                                  ])),
                          child: Center(
                              child: Text(
                            'Scan',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        )),
                  );
                })
          ],
        ),
      ),
    );
  }

  openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.of(context).pop(true);
          });
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  height: 100,
                  width: 100,
                  child: FlareActor(
                    statusBooking == 0
                        ? "assets/flare/Success Check.flr"
                        : "assets/flare/failure-check.flr",
                    animation: "Untitled",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
