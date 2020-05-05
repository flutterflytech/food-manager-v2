import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if (currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogInPage()));
      } else {
        Firestore.instance
            .collection("account")
            .document(currentUser.uid)
            .get()
            .then((DocumentSnapshot result) {
          if (result != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.network(
        'https://images-na.ssl-images-amazon.com/images/I/71-JgmazjTL.png',
        height: 200,
        width: 200,
      )),
    );
  }
}
