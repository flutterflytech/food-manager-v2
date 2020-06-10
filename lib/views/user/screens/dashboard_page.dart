import 'package:flutter/material.dart';

class DashboardUser extends StatefulWidget {
  final String userName;
  final String userSurname;

  const DashboardUser({Key key, this.userName, this.userSurname}) : super(key: key);

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
                Text('welcome' +' '+ widget.userName.toUpperCase()/*+' '+widget.userSurname.toUpperCase()*/),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
