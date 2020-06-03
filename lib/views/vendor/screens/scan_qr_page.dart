import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:food_manager_v2/constants/color_constants.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String qrCode;
  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      qrCode = barcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: (){
            _scan();
          },
          child: Text('Scan'),
        ),
      ),
    );
  }
}
