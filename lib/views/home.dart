import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/services/firebase_services/login_service.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/admin/screens/dashboard_page.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/user/screens/meal_detail_page.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/user/screens/payment_detail_page.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/admin/screens/user_profile_page.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/admin/screens/vendor_page.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/admin/screens/users_page.dart';

class HomePage extends StatefulWidget {
  final String user;
  final int userType;

  const HomePage({Key key, this.user, this.userType}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  bool isAdmin = true;
  int userType;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      getLoggedInUserData();
    });
  }

  int _currentIndex = 0;
  List<Widget> _childern = [];

  @override
  void initState() {
    super.initState();
// If user is admin, these pages will be Navigated
    if (userType == 1) {
      _childern = [
        Dashboard(user: widget.user,),
        VendorPage(),
        UsersPage(user: widget.user,),
        UserProfile(user: widget.user,),
      ];
    }
//    if user is not admin, these pages will be navigated
    else {
      _childern = [
        Dashboard(user: widget.user,),
        PaymentPage(),
        MealPage(),
        UserProfile(user: widget.user,),
      ];
    }
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
          BottomNavigationBarItem(
              icon: Icon(
                userType == 1
                    ? FontAwesomeIcons.utensils
                    : FontAwesomeIcons.moneyBill,
                size: 30,
                color: lightBlue1,
              ),
              title: Text(userType == 1 ? 'Vendors' : 'Payment', style: bold)),
          BottomNavigationBarItem(
              icon: Icon(
                userType == 1
                    ? FontAwesomeIcons.users
                    : FontAwesomeIcons.pizzaSlice,
                size: 30,
                color: lightBlue1,
              ),
              title: Text(userType == 1 ? 'Users' : 'Meals', style: bold)),
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

  getLoggedInUserData() async {
    LoginService loginService = LoginService();
    DocumentSnapshot snapshot = await loginService.loginUserData(widget.user);
    if (snapshot.data != null) {
      setState(() {

        userType = snapshot.data['vendor'];
        print(userType);
      });
    }
  }
  logout() {
    FirebaseAuth.instance.signOut();
  }
}
