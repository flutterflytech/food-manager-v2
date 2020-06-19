import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final userEmpId;
  final user;
  final userFName;
  final userSurname;

  const QRPage({Key key, this.userEmpId, this.user, this.userFName, this.userSurname}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String timeStamp;
  String userJson;

  @override
  void initState() {
//    Extracting date in format yyyy-mm-dd
    Timestamp timestamp = Timestamp.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
    var formatter = new DateFormat('yyyy-MM-dd');
    timeStamp = formatter.format(date);
//    passing user QR data to JSON for future uses
    userJson =
        '{"uid": "${widget.user}", "time": "$timeStamp","empId" : "${widget.userEmpId}", "userName":"${widget.userFName}", "userSurname": "${widget.userSurname}"}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//            Generating QR code in user login
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
