import 'package:flutter/material.dart';

//TODO put string files inside text_constants.dart file

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) => value.isEmpty ? 'Enter email' : null,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            cursorColor: Colors.blue[900],
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Email*',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0))),
          ),
          SizedBox(
            height: screenData.height * 0.01,
          ),
          TextFormField(
            validator: (value) =>
                value.length < 8 ? 'Enter strong password' : null,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            cursorColor: Colors.blue[900],
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Password*',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ],
      ),
    );
  }
}
