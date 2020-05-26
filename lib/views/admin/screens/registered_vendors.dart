import 'package:flutter/material.dart';

class RegisteredVendors extends StatefulWidget {
  @override
  _RegisteredVendorsState createState() => _RegisteredVendorsState();
}

class _RegisteredVendorsState extends State<RegisteredVendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Registered Vendors'),
          ),
        ),
      ),
    );
  }
}
