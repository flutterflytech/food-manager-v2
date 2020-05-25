import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/user/home_page_user.dart';
import 'package:food_manager_v2/views/vendor/home_page_vendor.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'firebase_services/login_service.dart';

class UnverifiedUserUI extends StatefulWidget {

  final String user;
  final int userType;

  const UnverifiedUserUI({Key key, this.user, this.userType}) : super(key: key);

  @override
  _UnverifiedUserUIState createState() => _UnverifiedUserUIState();
}

class _UnverifiedUserUIState extends State<UnverifiedUserUI> {
  bool _isEmailVerified = false;
  int userType;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Please wait',
    );
    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isEmailVerified
              ? _getVerifiedUserData(userType)
              : _getUnverifiedUserScreen(),
        );
  }
// To check email id is verified or not
  _checkVerificationStatus() async {
    try {
//      FirebaseUser user = await FirebaseAuth.instance.currentUser();
//      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//      userUpdateInfo.displayName = user.displayName;
//      user.updateProfile(userUpdateInfo).then((onValue) {
        FirebaseAuth.instance.currentUser().then((user) {
          _isEmailVerified = user.isEmailVerified;
          if (user.isEmailVerified) {
            setState(() {
              _isEmailVerified = true;
            });
          } else {
            AppUtils.showToast(notVerified, red, white);
          }
        });
//      });
    } catch (e) {
      print(errorVerification);
      AppUtils.showToast( errorVerification, red, white);
      print(e.message);
    }
  }
// This will be return on display if user has verified email id and login
  _getVerifiedUserData(int userType) {
    if(userType == 0){
      return HomePageUser();
    }
    else if(userType == 1){
      return HomePageUser();
    }
    else {
      return HomePageVendor();
    }

  }
// This will be return on display if email is not verified by user
  _getUnverifiedUserScreen() {
    return Center(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Resend Email'),
                color: Theme.of(context).primaryColor,
                textColor: white,
                onPressed: _sendMailAgain,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Already Verified'),
                textColor: white,
                onPressed: _checkVerificationStatus,
              ),
              IconButton(
                tooltip: 'Logout',
                onPressed: () {
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
    );

  }
// If user wants to send verification mail to registered email id
  _sendMailAgain() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification().then((_) {
        AppUtils.showToast(sendMail,
            green,white);
      }).catchError((error) {
        print(error.message);
      });
    } catch (e) {
      print(sendMailErrorToast);
      AppUtils.showToast(
          sendMailErrorToast,
          red,
          white);
      print(e.message);
    }
  }
// Check if user email is verified or not
  void getCurrentUserData() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        _isEmailVerified = user.isEmailVerified;
      });
    } catch (e) {
      print(userError);
    }
  }
  getLoggedInUserData() async {
    LoginService loginService = LoginService();
    DocumentSnapshot snapshot = await loginService.loginUserData(widget.user);
    if (snapshot.data != null) {
      setState(() {
        userType = snapshot.data['vendor'];
      });
    }
  }
}
