import 'package:flutter/material.dart';

class DashboardVendor extends StatefulWidget {
  final String userName;
  final String userSurname;

  const DashboardVendor({Key key, this.userSurname, this.userName})
      : super(key: key);

  @override
  _DashboardVendorState createState() => _DashboardVendorState();
}

class _DashboardVendorState extends State<DashboardVendor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('welcome' +
                    ' ' +
                    widget.userName +
                    ' ' +
                    widget.userSurname),
                Text('iconInfo'),
                Text('iconAction')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
