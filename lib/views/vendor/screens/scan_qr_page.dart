import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/models/record.dart';

class ScanQr extends StatefulWidget {
  final String user;

  const ScanQr({Key key, this.user}) : super(key: key);

  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String _scanQRCode;
  List<dynamic> bookingList = List();
  List<dynamic> userList = List();
  String qrCode;
//  String userJson =
//      '{"email": "", "uid": "${widget.user}", "userFName": "", "surName": "", "qrData": "", "reference": ""}';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
//    print(barcodeScanRes);
    Map map = jsonDecode(barcodeScanRes);
    Record record = Record.fromJson(map);
    print('record from json'+ record.uid +' '+record.userEmpId+' '+record.time);
    qrCode = record.uid;
    userList..add(record.time);
    bookingList..add(record.time);
//    ..add(record.userEmpId);
    setState(() {
      DocumentReference docRef = Firestore.instance.collection('bookings').document();
      docRef.setData({
        "bookingId":docRef.documentID,
        "timeStamp": record.time,
        "userId": record.uid,
        "vendorId": widget.user,
      });
      _scanQRCode = record.qrData;
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
