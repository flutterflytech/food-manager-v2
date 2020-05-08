import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/forgot_password_page.dart';
import 'package:food_manager_v2/views/home.dart';
import 'package:food_manager_v2/views/register_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

//TODO put string files inside text_constants.dart file

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal,isDismissible: false,showLogs: false);
    pr.style(
      message: 'Please wait...'
    );
  }

  showProgressDialog(bool isShow){
    if(isShow){
      pr.show();
    }else{
      pr.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenData.height*0.2,
                  ),
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
                  TextFormField(
                    validator: (value) => value.length < 8 ? 'Enter strong password' : null,
                    onChanged: (value){
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
                    height: screenData.height * 0.05,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 180.0,top: 8.0),
                      child: InkWell(
                        child: Text('Forgot Password?'),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenData.height * 0.05,
                  ),
                  SizedBox(
                    height: screenData.height * 0.07,
                    width: screenData.width * 1.0,
                    child: GestureDetector(
                      onTap: (){
                        if(_formKey.currentState.validate()){
                          showProgressDialog(true);
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((currentUser){
                            showProgressDialog(true);
                            Firestore.instance.collection("account").document(currentUser.user.uid).get().then((DocumentSnapshot result) {
                              showProgressDialog(false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                   /* title: ('Welcome Back ' +
                                        result.data["fname"])
                                        .toUpperCase(),
                                    uid: currentUser.user.uid,*/
                                  ),
                                ),
                              );
                            }).catchError((err){
                              showProgressDialog(false);

                              AppUtils.showToast(err.message,Colors.red[900], Colors.white);
                            });
                          }).catchError((err){
                            showProgressDialog(false);

                            AppUtils.showToast(err.message, Colors.red[900], Colors.white);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.blue[700], Colors.blue[200]]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenData.height * 0.02,
                  ),
                  Text("Don't have an account yet?"),
                  SizedBox(
                    height: screenData.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                    },
                    child: Text('Register here!',style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
