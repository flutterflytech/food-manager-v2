import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Column(

      children: <Widget>[
        TextFormField(

          cursorColor: Colors.blue[900],
          decoration: InputDecoration(

              fillColor: Colors.white,
              filled: true,
              hintText: 'Email*',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0))),
        ),
        SizedBox(
          height: screenData.height * 0.01,
        ),
        TextField(

          cursorColor: Colors.blue[900],
          obscureText: true,
          decoration: InputDecoration(

              fillColor: Colors.white,
              filled: true,
              hintText: 'Password*',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0))),
        ),
      ],

    );
  }
}
