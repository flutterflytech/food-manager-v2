import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/main.dart';
import 'package:food_manager_v2/models/record.dart';

class ScanQr extends StatefulWidget {
  final String user;
  final String userFName;
  final String userSurname;

  const ScanQr({Key key, this.user, this.userFName, this.userSurname}) : super(key: key);

  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {

  List<dynamic> bookingList = List();
  List<dynamic> userList = List();
  String qrCode;
  bool paymentStatus = false;

  Future<void> scanBarcodeNormal() async {
    // String barcodeScanRes;
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    Map map = jsonDecode(barcodeScanRes);
    print(barcodeScanRes);
    Record record = Record.fromJson(map);
    print(record.toString());

//    setting Data received from QR code into firebase collection
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
        "mealPrice":priceList[record.mealType].price,
        "mealName":priceList[record.mealType].foodName,
        "paymentStatus":paymentStatus,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            scanBarcodeNormal();
          },
          child: Text('Scan'),
        ),
      ),
    );
  }
}
