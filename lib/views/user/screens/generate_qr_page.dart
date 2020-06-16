import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {

  final userEmpId;
  final user;

  const QRPage({Key key, this.userEmpId, this.user}) : super(key: key);
  @override
  _QRPageState createState() => _QRPageState();
}
class _QRPageState extends State<QRPage> {
  String timeStamp;

  var now = DateTime.now();
  String userJson;





//  var qrData = Record.parsedJson);

  parseJSON(String userJson){
    Map parsedJson = json.decode(userJson);
    var qrData = Record.fromMap(parsedJson);
  }

  @override
  void initState() {
    Timestamp timestamp = Timestamp.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
    var formatter = new DateFormat('yyyy-MM-dd');
    timeStamp = formatter.format(date);

    userJson ='{"uid": "${widget.user}", "time": "$timeStamp","empId" : "${widget.userEmpId}"}';


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            QrImage(

              foregroundColor: darkBlue,
              data: userJson,
              version: QrVersions.auto,
              size: 400.0,
            ),
            Text('Show this QR Code to Food Vendor')
          ],
        ),
      ),
    );
  }

}
