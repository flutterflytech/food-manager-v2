import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final userFName;
  final userSurname;
  final userEmpId;

  const QRPage({Key key, this.userFName, this.userSurname, this.userEmpId}) : super(key: key);
  @override
  _QRPageState createState() => _QRPageState();
}
class _QRPageState extends State<QRPage> {
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: QrImage(
          foregroundColor: darkBlue,
          data: widget.userFName.toUpperCase()+' '+widget.userSurname.toUpperCase()+'/'+widget.userEmpId+'/'+now.toString(),
          version: QrVersions.auto,
          size: 400.0,
        ),
      ),
    );
  }

  _date(){
    var now = DateTime.now();
    print(now);
  }

}
