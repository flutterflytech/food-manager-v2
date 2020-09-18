import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/admin/screens/dashboard_page.dart';
import 'package:food_manager_v2/views/admin/screens/registered_admins.dart';
import 'package:food_manager_v2/views/admin/screens/registered_users.dart';
import 'package:food_manager_v2/views/admin/screens/profile_page_admin.dart';
import 'package:food_manager_v2/views/admin/screens/registered_vendors.dart';

import '../login_page.dart';

class HomePageAdmin extends StatefulWidget {
  final String user;
  final String userName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;
  final String uid;

  const HomePageAdmin(
      {Key key,
      this.user,
      this.userName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl,
      this.uid})
      : super(key: key);

  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  List<Widget> _childern = [];

  @override
  void initState() {
    super.initState();

// If user is admin, these pages will be Navigated

    _childern = [
      Dashboard(userName: widget.userName, userSurname: widget.userSurname),
      UserProfileAdmin(
        user: widget.user,
        fName: widget.userName,
        photoUrl: widget.photoUrl,
        userEmail: widget.userEmail,
        userEmpId: widget.userEmpId,
        userSurname: widget.userSurname,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Manager'),
        centerTitle: true,
        actions: <Widget>[

          //Action Button actions
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Registered Admins',
                'Registered Vendors',
                'Registered Users',
                'Logout',
                'App Info'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _childern[_currentIndex],
      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        elevation: 0,
        currentIndex: _currentIndex,
        items: [
          //Dashboard
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: 30,
                color: lightBlue1,
              ),
              title: Text(
                'Home',
                style: bold,
              )),
          //User Profile
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.houseUser,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Profile', style: bold)),
        ],
      ),
    );
  }

  logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogInPage()));
  }


  //Action Button Click Handler
  void handleClick(String value) {
    switch (value) {
      case 'Registered Vendors':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisteredVendors(),
            ));
        break;
      case 'Registered Users':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisteredUsers()
            ));
        break;
      case 'Registered Admins':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisteredAdmins(),
            ));
        break;
      case 'Logout':
        logout();
        break;
      case 'App Info':
        showAboutDialog(
          context: context,
          applicationName: 'Food Manager',
          applicationVersion: 'v2.0',
        );
    }
  }
}
