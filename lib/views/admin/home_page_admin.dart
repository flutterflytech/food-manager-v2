import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/admin/screens/dashboard_page.dart';
import 'package:food_manager_v2/views/admin/screens/registered_admins.dart';
import 'package:food_manager_v2/views/admin/screens/registered_users.dart';
import 'package:food_manager_v2/views/admin/screens/user_profile_page_admin.dart';
import 'package:food_manager_v2/views/admin/screens/users_page.dart';
import 'package:food_manager_v2/views/login_page.dart';

class HomePageAdmin extends StatefulWidget {
  final String user;
  final String userName;
  final String fName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;
  final String uid;

  const HomePageAdmin({Key key, this.user, this.userName, this.fName, this.userEmail, this.userEmpId, this.userSurname, this.photoUrl, this.uid}) : super(key: key);

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
      Dashboard(
        user: widget.userName,
      ),

      UserProfile(

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

          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Registered Admins','Registered Vendors','Registered Users','Logout'}.map((String choice) {
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
              title: Text(
                'Home',
                style: bold,
              )),
         /* BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.utensils,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Vendors', style: bold)),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.users,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Users', style: bold)),*/
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
      context,
      MaterialPageRoute(
        builder: (context) => LogInPage(),
      ),
    );
  }
  UserPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>RegisteredUsers(),));
  }
  VendorPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>RegisteredAdmins(),));
  }
  AdminPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>RegisteredAdmins(),));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Registered Vendors': VendorPage();
        break;
      case 'Registered Users': UserPage();
        break;
      case 'Registered Admins': AdminPage();
        break;
      case 'Logout': logout();
        break;
    }
  }
}
