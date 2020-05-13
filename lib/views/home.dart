import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/views/bottom_navigation/user_profile_page.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/users_page.dart';

class HomePage extends StatefulWidget {
  final String user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//TODO put string files inside text_constants.dart file
class _HomePageState extends State<HomePage> {
  String loggedInUserFname = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Manager'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.home,
                    size: 30,
                    color: lightBlue1,
                  ),
                  tooltip: 'Home',
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.utensils,
                    size: 30,
                    color: lightBlue1,
                  ),
                  tooltip: 'Vendor',
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.users,
                    size: 30,
                    color: lightBlue1,
                  ),
                  tooltip: 'Users',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UsersPage()));
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.houseUser,
                    size: 30,
                    color: lightBlue1,
                  ),
                  tooltip: 'Profile',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfile(
                                  user: widget.user,
                                )));
                  }),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(welcome + ' ' + loggedInUserFname.toUpperCase()),
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
      ),
    );
  }

  getLoggedInUserData() async {
    await Firestore.instance
        .collection('account')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot snapshot) {
      //TODO User details are available only after restart.
      if (snapshot.data != null) {
        print(snapshot.data);
        setState(() {
          loggedInUserFname = snapshot.data['fname'];
        });
      }
    });
  }
}
