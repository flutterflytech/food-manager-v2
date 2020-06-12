import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {

  final userEmpId;
  final user;

  const QRPage({Key key, this.userEmpId, this.user}) : super(key: key);
  @override
  _QRPageState createState() => _QRPageState();
}
class _QRPageState extends State<QRPage> {



  var now = DateTime.now();
  String userJson ='{"email": "", "uid": "test", "userFName": "", "surName": "", "qrData": "", "reference": ""}';
  Record userProfileData;

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
