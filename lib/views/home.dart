import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/bottom_navigation/dashboard_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/user_profile_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/vendor_page.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/users_page.dart';

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  int _currentIndex = 0;
  final List<Widget> _childern = [
    Dashboard(),
    VendorPage(),
    UsersPage(),
    UserProfile(),
  ];
  //to be removed
  static String loggedInUserLastName = '';
  static String loggedInUserFirstName = '';
  static String loggedInUserEmail = '';
  static String loggedInUserEmployeeId = '';
  static String loggedInUserUid = '';
  //to be removed




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

      body: _childern[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        elevation: 0,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Home', style: bold,)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.utensils,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Vendors', style: bold)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.users,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Users', style: bold)
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.houseUser,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Profile', style: bold)
          ),
        ],
      ),
      /*SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(welcome + ' ' + loggedInUserName.toUpperCase()),
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
      ),*/
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
          loggedInUserEmail = snapshot.data['email'];
          loggedInUserFirstName = snapshot.data['fname'];
          loggedInUserLastName = snapshot.data['surname'];
          loggedInUserEmployeeId = snapshot.data['empId'];
          loggedInUserUid = snapshot.data['uid'];

        });
      }
    });
  }
}
