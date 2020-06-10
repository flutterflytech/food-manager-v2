import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool obscure = true;

  void _toggleVisibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(message: 'Logging you in...');
    getLoggedInUserData();
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
                  /*CustomTextFormField(

                    validator: passwordValidator,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    hintText: 'Password',
                    obscure: true,
                  )*/
                  TextFormField(
                    validator: passwordValidator,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    cursorColor: darkBlue,
                    obscureText: obscure,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          splashColor: white,
                          onPressed: _toggleVisibility,
                          icon: obscure
                              ? Icon(FontAwesomeIcons.eye)
                              : Icon(FontAwesomeIcons.eyeSlash),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightBlue2, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: darkBlue2, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0))),
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
      showProgressDialog(true);
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      LoginService();
      if (result != null) {
        showProgressDialog(false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UnverifiedUserUI(),
          ),
        );
      }
    }
  }

  getLoggedInUserData() async {
    LoginService loginService = LoginService();
    DocumentSnapshot snapshot = await loginService.loginUserData(widget.user);
    if (snapshot.data != null) {
      setState(() {
        var userData = AllUserData.formFireStore(snapshot.data);
        print('data from model class*&' + userData.userType.toString());
        userType = userData.userType;
        print('data @@@ from model class ' + userType.toString());

//        uid = snapshot.data['uid'];
//        print('#@#' + widget.userType.toString());
      });
    }
  }
}
