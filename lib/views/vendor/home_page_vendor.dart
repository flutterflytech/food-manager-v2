import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/vendor/screens/bookings_page.dart';
import 'package:food_manager_v2/views/vendor/screens/dashboard_page_vendor.dart';
import 'package:food_manager_v2/views/vendor/screens/profile_page_vendor.dart';
import 'package:food_manager_v2/views/vendor/screens/scan_qr_page.dart';

class HomePageVendor extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;
  final String user;
  final int userType;

  const HomePageVendor(
      {Key key,
      this.userName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl,
      this.userType,
      this.user})
      : super(key: key);

  @override
  _HomePageVendorState createState() => _HomePageVendorState();
}

class _HomePageVendorState extends State<HomePageVendor> {
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

//    if user is not admin, these pages will be navigated

    _childern = [
      DashboardVendor(
        userName: widget.userName,
        userSurname: widget.userSurname,
      ),
      ScanQr(
        user: widget.user,
        userFName: widget.userName,
        userSurname: widget.userSurname,
      ),
      Bookings(
        user: widget.user,
      ),
      UserProfileVendor(
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
          IconButton(
            onPressed: () {
              logout();
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
//          dashboard
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
//       Scan QR
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.qrcode,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Scan QR', style: bold)),
//        Bookings
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bootstrap,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Bookings', style: bold)),
//          Profile
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
}
