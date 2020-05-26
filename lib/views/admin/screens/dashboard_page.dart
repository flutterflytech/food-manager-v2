import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/services/firebase_services/login_service.dart';

class Dashboard extends StatefulWidget {
  final String user;

  const Dashboard({Key key, this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String loggedInUserName = '';

  @override
  void initState() {
    super.initState();
    getLoggedInUserData();
  }

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
                Text(welcome + ' ' + widget.user),
                Text(iconInfo),
                Icon(
                  FontAwesomeIcons.users,
                ),
                Text(iconAction)
              ],
            ),
          ],
        ),
      ),
    );
  }
// Fetching data of Logged In user
  getLoggedInUserData() async {
    LoginService loginService = LoginService();
    DocumentSnapshot snapshot = await loginService.loginUserData(widget.user);
    if (snapshot.data != null) {
      setState(() {
        loggedInUserName = snapshot.data['fname'];
      });
    }
  }
}
