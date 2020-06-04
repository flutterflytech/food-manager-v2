import 'package:flutter/material.dart';

class RegisteredAdmins extends StatefulWidget {
  @override
  _RegisteredAdminsState createState() => _RegisteredAdminsState();
}

class _RegisteredAdminsState extends State<RegisteredAdmins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Registered Admins'),
          ),
        ),
      ),
    );
  }
}
