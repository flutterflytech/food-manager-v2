import 'package:flutter/material.dart';

class DashboardUser extends StatefulWidget {
  final user;

  const DashboardUser({Key key, this.user}) : super(key: key);
  @override
  _DashboardUserState createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
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
                Text('welcome' + ' ' + widget.user),
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
