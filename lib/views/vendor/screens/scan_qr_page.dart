import 'dart:convert';
import 'package:food_manager_v2/constants/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:food_manager_v2/utils/app_utils.dart';

class ScanQr extends StatefulWidget {
  final String user;

  const ScanQr({Key key, this.user}) : super(key: key);
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String _scanQRCode;
  List<dynamic> bookingList = List();
  String qrCode;
  String userJson =
      '{"email": "", "uid": "test", "userFName": "", "surName": "", "qrData": "", "reference": ""}';


  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);

setState(() {
  Firestore.instance.collection('bookings').document(widget.user).setData({
    "bookingData": bookingList
  }).then((result){});
  _scanQRCode = barcodeScanRes;
});

  /*  Timestamp timestamp = Timestamp.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    print(formatted);*/

/*    Map map = jsonDecode(barcodeScanRes);
    Record record = Record.fromJson(map);
    if (record.qrData.compareTo(record.uid ) != 0) {
      AppUtils.showToast('Invalid QR code', Colors.red, Colors.white);
      return;
    }

    if (bookingList.contains(record.uid)) {
      AppUtils.showToast(
          'Dear ${record.userFName}, You have already received your lunch.',
          Colors.red,
          Colors.white);
    } else {
      bookingList.add(record.uid);
      setState(() {
        Firestore.instance
            .collection(AppConstants.DB_KEY_BOOKING_DATA)
            .document('bookings')
            .setData({
          AppConstants.KEY_BOOKING_LIST: bookingList,
        }).then((result) {});
        _scanQRCode = barcodeScanRes;
        AppUtils.showToast('Dear ${record.userFName}, Enjoy your lunch.😋',
            Colors.green, Colors.white);
      });
    }*/
  }

  /*Future _scan() async {
    String barcodeScanRes;
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#467af2", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);


    Map map = jsonDecode(barcodeScanRes);
    Record record = Record.fromJson(map);

    setState(() {
      Firestore.instance
          .collection('bookings')
          .document()
          .setData({
        'booking_list': bookingList,
      }).then((result) {});
      _scanQRCode = barcodeScanRes;
      AppUtils.showToast('Dear ${record.userFName}, Enjoy your lunch.😋',
          Colors.green, Colors.white);
      });

  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: (){
           scanBarcodeNormal();
          },
          child: Text('Scan'),
        ),
      ),
    );
  }
}
