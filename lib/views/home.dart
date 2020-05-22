import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/bottom_navigation/dashboard_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/meal_detail_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/payment_detail_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/user_profile_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/vendor_page.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/users_page.dart';

class HomePage extends StatefulWidget {
  final String user;
  final bool isAdmin;

  const HomePage({Key key, this.user, this.isAdmin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = true;
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

    if(isAdmin){
      _childern=[
        Dashboard(user: widget.user,),
        VendorPage(),
        UsersPage(user: widget.user,),
        UserProfile(user: widget.user,),
      ];
    }else{
      _childern=[
        Dashboard(user: widget.user,),
        PaymentPage(),
        MealPage(),
        UserProfile(user: widget.user,),
      ];
    }





/*    _childern[0]=Dashboard(user: widget.user,);
    _childern[1]=MealPage();
    _childern[2]=PaymentPage();
    _childern[3]=UserProfile(user: widget.user,);
if(widget.isAdmin){
  _childern[1]=VendorPage();
  _childern[2]=UsersPage(
    user: widget.user,
  );
}*/

    /*_childern = [
      Dashboard(
        user: widget.user,
      ),
      VendorPage(),
      UsersPage(
        user: widget.user,
      ),
      UserProfile(
        user: widget.user,
      ),
    ]*/

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
              title: Text('Users', style: bold)),
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

  logout(){
    FirebaseAuth.instance.signOut();
  }

}
