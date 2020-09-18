import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(80,40),bottomRight: Radius.elliptical(80,40))),
        title: Text('Forgot Password?'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(color: Colors.blue[200]),
                      child: Text(
                        displayMessage,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Enter your email' : null,
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
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0))),
                  ),
                ),
                SizedBox(
                  height: screenData.height * 0.05,
                ),
                RaisedButton(
                  child: Text('Send Email'),
                  onPressed: () {
//                    sending mail to reset password
                    if (_formKey.currentState.validate()) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email)
                          .then((_) {
                        AppUtils.showToast('Check Your Email to reset password',
                            Colors.green[700], Colors.white);
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()));
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
