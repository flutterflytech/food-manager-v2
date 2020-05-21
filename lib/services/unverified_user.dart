import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/home.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UnverifiedUserUI extends StatefulWidget {
  final bool isAdmin;

  const UnverifiedUserUI({Key key, this.isAdmin}) : super(key: key);


  @override
  _UnverifiedUserUIState createState() => _UnverifiedUserUIState();
}

class _UnverifiedUserUIState extends State<UnverifiedUserUI> {
  bool _isEmailVerified = false;
  bool isAdmin = true;
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
              ? _getVerifiedUserData()
              : _getUnverifiedUserData(),
        );
  }

  _checkVerificationStatus() async {
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
                red, white);
          }
        });
      });
    } catch (e) {
      print('An error occurred while trying to check email is verified or not!');
      AppUtils.showToast(
          'An error occurred while trying to check email is verified or not!',
          red,
          white);
      print(e.message);
    }
  }

  _getVerifiedUserData() {
    return HomePage(isAdmin: isAdmin,);
  }

  _getUnverifiedUserData() {
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

  _sendMailAgain() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification().then((_) {
        AppUtils.showToast('Email verification link send successfully.',
            green,white);
      }).catchError((error) {
        print(error.message);
      });
    } catch (e) {
      print("An error occurred while trying to send email verification");
      AppUtils.showToast(
          'An error occurred while trying to send email verification',
          red,
          white);
      print(e.message);
    }
  }

  void getCurrentUserData() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        _isEmailVerified = user.isEmailVerified;
      });
    } catch (e) {
      print("An error occurred while trying to get current user.");
    }
  }
}
