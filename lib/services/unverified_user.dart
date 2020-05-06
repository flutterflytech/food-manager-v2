import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';


class UnverifiedUserUI extends StatefulWidget {
  @override
  _UnverifiedUserUIState createState() => _UnverifiedUserUIState();
}

class _UnverifiedUserUIState extends State<UnverifiedUserUI> {
  bool _isEmailVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: _isEmailVerified ? _getVerifiedUserData() : _getUnverifiedUserData(),
        )
    );
  }

  _checkVerificationStatus() async{
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = user.displayName;
      user.updateProfile(userUpdateInfo).then((onValue) {
        FirebaseAuth.instance.currentUser().then((user) {

          _isEmailVerified = user.isEmailVerified;
          if (user.isEmailVerified) {
            setState(() {
              _isEmailVerified = true;
            });
          } else {
            AppUtils.showToast('You haven\'t verified your email yet!',
                Colors.red, Colors.white);
          }
        });
      });
    } catch (e) {

      print('An error occured while trying to check email is verified or not!');
      AppUtils.showToast(
          'An error occured while trying to check email is verified or not!',
          Colors.red,
          Colors.white);
      print(e.message);
    }
  }

  _getVerifiedUserData(){
    return[
      Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Welcome Verified User'),
              IconButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
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
        ),
      )
    ];
  }

  _getUnverifiedUserData(){

    return[
      Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Resend Email'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _sendMailAgain,
              ),
              RaisedButton(

                color:Theme.of(context).primaryColor,
                child: Text('Already Verified'),
                textColor: Colors.white,
                onPressed: _checkVerificationStatus,

              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                },
              )
            ],
          ),
        ),
      )
    ];

  }

  _sendMailAgain() async{

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification().then((_) {

        AppUtils.showToast('Email verification link send successfuly.',
            Colors.green, Colors.white);
      }).catchError((error) {

        print(error.message);
      });
    } catch (e) {

      print("An error occured while trying to send email verification");
      AppUtils.showToast(
          'An error occured while trying to send email verification',
          Colors.red,
          Colors.white);
      print(e.message);
    }

  }
}
