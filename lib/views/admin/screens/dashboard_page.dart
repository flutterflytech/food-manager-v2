import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/text_constants.dart';

class Dashboard extends StatefulWidget {
  final String userName;
  final String userSurname;

  const Dashboard({
    Key key,
    this.userName,
    this.userSurname,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
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
                // User First and Last Names
                Text(welcome + ' ' + widget.userName + ' ' + widget.userSurname),
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
}
