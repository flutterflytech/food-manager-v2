import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_manager_v2/constants/color_constants.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String qrCode;
  Future scanBarcode() async{
    String scanResult = await FlutterBarcodeScanner.scanBarcode('0xFF1976D2', 'Terminate', true, ScanMode.QR);
    setState(() {
          qrCode = scanResult;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: scanBarcode,
        child: Text('Scan'),
      ),
    );
  }
}
