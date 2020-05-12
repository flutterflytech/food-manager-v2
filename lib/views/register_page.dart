import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/services/auth.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/widgets/custom_text_form_filed.dart';
import 'package:progress_dialog/progress_dialog.dart';

//TODO put string files inside text_constants.dart file

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ProgressDialog pr;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();



  String error = '';
  String firstName = '';
  String lastName = '';
  String empId = '';
  String email = '';
  String password = '';
  // String uid = '';
  int vendor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr.style(message: toastMsg);


  }

  showProgressDialog(bool isShow) {
    if (isShow) {
      pr.show();
    } else {
      pr.hide();
    }
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      return emailVal;
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return pwdVal;
    } else {
      return null;
    }
  }

  String firstNameValidator(String value) {
    if (value.length == 0) {
      return fNameVal;
    } else {
      return null;
    }
  }

  String lastNameValidator(String value) {
    if (value.length == 0) {
      return lNameVal;
    } else {
      return null;
    }
  }

  String employeeIdValidator(String value) {
    if (value.length != 3) {
      return empVal;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(

                      hintText: 'First Name*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      hintText: 'Last Name*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      hintText: 'Employee Id*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      hintText: 'Email*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      hintText: 'Password*',
                      obscure: true,
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: onRegisterClick,
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [buttonColor1, buttonColor2]),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(color: white, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenData.height * 0.02,
                    ),
                    Text(existingAccount),
                    SizedBox(
                      height: screenData.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()));
                      },
                      child: Text(
                        loginButton,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onRegisterClick() async {
    if (_formKey.currentState.validate()) {
      showProgressDialog(true);
      dynamic result = await _auth.registerWithEmailAndPassword(
          email, password, empId, firstName, lastName,  vendor);
      Navigator.pop(context);
      AppUtils.showToast(registerToast, successMessageColor, white);
      if (result == null) {
        setState(() {
          error = registerErrorToast;
        });
      } else {
        Navigator.pop(context);
      }
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((currentUser) {
        try {
          currentUser.user.sendEmailVerification();
        } catch (e) {
          showProgressDialog(false);
          print(sendMailErrorToast);
          AppUtils.showToast(
              sendMailErrorToast,
              errorMessageColor,
              white);
          print(e.message);
        }
      });
    }
  }
}
