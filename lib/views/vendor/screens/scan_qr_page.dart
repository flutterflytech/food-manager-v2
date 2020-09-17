import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/main.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:food_manager_v2/widgets/open_dialog.dart';

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
  OpenDialog openDialog = OpenDialog();
  List<dynamic> bookingList = List();
  List<dynamic> userList = List();
  String qrCode;
  bool paymentStatus = false;
  bool bookingStatus;

  Future<void> scanBarcodeNormal() async {
    // String barcodeScanRes;
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    Map map = jsonDecode(barcodeScanRes);
    // print(barcodeScanRes);
    Record record = Record.fromJson(map);
    // print(record.toString());

    DocumentReference documentReference =
        Firestore.instance.collection('account').document(record.uid);
    var a = await documentReference.get();
    List list = a["recentBookings"] as List;

    if (a["lastBookingDate"] == record.time || a["lastBookingDate"] == null) {
      if (list.contains(record.mealType)) {
        print('Booking Error ');
        setState(() {
          bookingStatus = false;
        });

      } else {
        list.add(record.mealType);
        documentReference.updateData({
          "lastBookingDate": record.time,
          "recentBookings": list,
        });
        setState(() {
          DocumentReference docRef =
              Firestore.instance.collection('bookings').document();
          docRef.setData({
            "bookingId": docRef.documentID,
            "timeStamp": record.time,
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
          bookingStatus = true;
        });

      }
    } else {
      // list.add(record.mealType);
      documentReference.updateData({
        "lastBookingDate": record.time,
        "recentBookings": [record.mealType],
      });
      setState(() {
        DocumentReference docRef =
            Firestore.instance.collection('bookings').document();
        docRef.setData({
          "bookingId": docRef.documentID,
          "timeStamp": record.time,
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
        bookingStatus = true;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.width * 1.0,
              width: MediaQuery.of(context).size.width * 1.0,
              child: FlareActor(
                "assets/flare/scan_qr.flr",
                // "assets/flare/Success Check.flr",
                // "assets/flare/failure.flr",
                animation: "scan",
                fit: BoxFit.cover,
                color: Colors.blue[900],
              )),
          GestureDetector(
            onTap: () {
              scanBarcodeNormal();
              // if(bookingStatus==true){
              //   OpenDialog();
              // }else{
              //   Dialog(
              //     shape:
              //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              //     child: Container(
              //         height: 200,
              //         width: 200,
              //         child: FlareActor(
              //           // "assets/flare/scan_qr.flr",
              //           // "assets/flare/Success Check.flr",
              //           "assets/flare/failure.flr",
              //           animation: "failure",
              //           fit: BoxFit.cover,
              //           color: Colors.blue[900],
              //         )),
              //   );
              // }
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
          )
        ],
      ),
    );
  }
}
