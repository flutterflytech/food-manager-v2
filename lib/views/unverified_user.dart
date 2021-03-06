import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/bloc/user_type.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/admin/home_page_admin.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/user/home_page_user.dart';
import 'package:food_manager_v2/views/vendor/home_page_vendor.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase_services/login_user_data_service.dart';

class UnverifiedUserUI extends StatefulWidget {
  final String user;

  const UnverifiedUserUI({Key key, this.user}) : super(key: key);

  @override
  _UnverifiedUserUIState createState() => _UnverifiedUserUIState();
}

class _UnverifiedUserUIState extends State<UnverifiedUserUI> {
  UserTypeBLoC userValue = UserTypeBLoC();
  bool _isEmailVerified = false;
  int userType;
  String userName;
  String userEmail;
  String userEmpId;
  String userSurname;
  String photoUrl;
  String uid;
  ProgressDialog pr;

  @override
  void initState() {
    getLoggedInUserData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Please wait',
    );
    getCurrentUserData();
  }

  showProgressDialog(bool isShow) {
    if (isShow) {
      pr.show();
    } else {
      pr.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: userValue.userStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: _isEmailVerified
                ? _getVerifiedUserData(
                    snapshot.data,
                    uid,
                    userName,
                    userSurname,
                    userEmpId,
                    userEmail,
                    photoUrl,
                  )
                : _getUnverifiedUserScreen(),
          );
        });
  }

// To check email id is verified or not
  _checkVerificationStatus() async {
    try {
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
    } catch (e) {
      print(errorVerification);
      AppUtils.showToast(errorVerification, red, white);
      print(e.message);
    }
  }

// This will be return on display if user has verified email id and login
  _getVerifiedUserData(
    int userType,
    String uid,
    String userName,
    String userSurname,
    String userEmpId,
    String userEmail,
    String photoUrl,
  ) {
    sharedPreferences();

    switch (userType) {
      case 0:
        return HomePageUser(
          user: uid,
          userName: userName,
          userSurname: userSurname,
          userEmpId: userEmpId,
          userEmail: userEmail,
          photoUrl: photoUrl,
        );

      case 1:
        return RegisteredList(
          user: widget.user,
          userName: userName,
          userSurname: userSurname,
          userEmpId: userEmpId,
          userEmail: userEmail,
          photoUrl: photoUrl,
        );
      case 2:
        return HomePageVendor(
          user: widget.user,
          userName: userName,
          userSurname: userSurname,
          userEmpId: userEmpId,
          userEmail: userEmail,
          photoUrl: photoUrl,
        );

      default:
        return Center(child: Text('Switch Default Case'));
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
        AppUtils.showToast(sendMail, green, white);
      }).catchError((error) {
        print(error.message);
      });
    } catch (e) {
      print(sendMailErrorToast);
      AppUtils.showToast(sendMailErrorToast, red, white);
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
    LoginUserData loginUserData = LoginUserData();
    DocumentSnapshot snapshot = await loginUserData.loginUserData(widget.user);
    if (snapshot.data != null) {
      setState(() {
        var userData = AllUserData.formFireStore(snapshot.data);
        print('data from model class ' + userData.userType.toString());
        userValue.userSink.add(userData.userType);
        userType = userData.userType;
        userName = userData.userFName;
        userEmail = userData.userEmail;
        userEmpId = userData.userEmpId;
        userSurname = userData.userSurname;
        photoUrl = userData.photoUrl;
        uid = userData.uid;
        print('!@#@@' + uid);
        print(snapshot.data.toString());
      });
    }
  }

  sharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userType', userType);
    userType = prefs.getInt('userType');
  }
}
