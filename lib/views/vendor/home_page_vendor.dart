import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/views/login_page.dart';

class HomePageVendor extends StatefulWidget {
  @override
  _HomePageVendorState createState() => _HomePageVendorState();
}

class _HomePageVendorState extends State<HomePageVendor> {
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
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Vendor'),
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

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        logout();
        break;
    }
  }
}
