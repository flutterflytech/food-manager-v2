import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/admin/screens/dashboard_page.dart';
import 'package:food_manager_v2/views/admin/screens/user_profile_page_admin.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/user/screens/meal_detail_page.dart';
import 'package:food_manager_v2/views/user/screens/payment_detail_page.dart';

class HomePageUser extends StatefulWidget {
  final String user;

  const HomePageUser({Key key, this.user}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
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
      Dashboard(
        user: widget.user,
      ),
      PaymentPage(),
      MealPage(),
      UserProfile(
        user: widget.user,
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
                FontAwesomeIcons.moneyBill,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Payment', style: bold)),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.pizzaSlice,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Meals', style: bold)),
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
  }
}
