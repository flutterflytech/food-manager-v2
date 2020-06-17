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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    Map map = jsonDecode(barcodeScanRes);
    Record record = Record.fromJson(map);
//    setting Data received from QrR code into firebase collection
    setState(() {
      DocumentReference docRef =
          Firestore.instance.collection('bookings').document();
      docRef.setData({
        "bookingId": docRef.documentID,
        "timeStamp": record.time,
        "userId": record.uid,
        "vendorId": widget.user,
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
