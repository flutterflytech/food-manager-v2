import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/services/firebase_services/auth.dart';
import 'package:food_manager_v2/services/firebase_services/login_service.dart';
import 'package:food_manager_v2/services/unverified_user.dart';
import 'package:food_manager_v2/views/forgot_password_page.dart';
import 'package:food_manager_v2/views/register_page.dart';
import 'package:food_manager_v2/widgets/custom_text_form_filed.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LogInPage extends StatefulWidget {
  final String user;

  const LogInPage({Key key, this.user}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthService _auth = AuthService();

//  AllUserData _userData = AllUserData();
  Map userData;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password;
  String userFName;
  String userEmail;
  String userEmpId;
  String userSurname;
  String photoUrl;
  String userUid;
  int userType;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: 'Please wait...');
  }

  String emailValidator(String value) {
    if (value.length == 0) {
      return emailValMsg;
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return pwdValMsg;
    } else {
      return null;
    }
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
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenData.height * 0.2,
                  ),
                  CustomTextFormField(
                    validator: emailValidator,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: screenData.height * 0.01,
                  ),
                  CustomTextFormField(
                    validator: passwordValidator,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    hintText: 'Password',
                    obscure: true,
                  ),
                  SizedBox(
                    height: screenData.height * 0.05,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 180.0, top: 8.0),
                      child: InkWell(
                        child: Text(forgotPassword),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenData.height * 0.05,
                  ),
                  InkWell(
                    onTap: _onLogInClick,
                    child: SizedBox(
                      height: screenData.height * 0.07,
                      width: screenData.width * 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: [darkBlue2, lightBlue2]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          "LOGIN",
                          style: body15,
                        )),
                      ),
                    ),
                    highlightColor: lightBlue1,
                  ),
                  SizedBox(
                    height: screenData.height * 0.02,
                  ),
                  Text(createAccount),
                  SizedBox(
                    height: screenData.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      registerButton,
                      style: bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onLogInClick() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      LoginService();

      if (result != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UnverifiedUserUI(),
          ),
        );
      }
    }
  }
}
