import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/services/firebase_services/auth.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/widgets/custom_text_form_filed.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
  String url = '';
  int vendor = 0;

  @override
  void initState() {
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
      return emailValMsg;
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return pwdValMsg;
    } else {
      return null;
    }
  }

  String firstNameValidator(String value) {
    if (value.length == 0) {
      return nameValMsg;
    } else {
      return null;
    }
  }

  String lastNameValidator(String value) {
    if (value.length == 0) {
      return nameValMsg;
    } else {
      return null;
    }
  }

  String employeeIdValidator(String value) {
    if (value.length != 3) {
      return empValMsg;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(80, 40),
                bottomRight: Radius.elliptical(80, 40))),
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
                      validator: firstNameValidator,
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                      hintText: 'First Name*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      validator: lastNameValidator,
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                      hintText: 'Last Name*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      validator: employeeIdValidator,
                      onChanged: (value) {
                        setState(() {
                          empId = 'MOB' + value;
                        });
                      },
                      hintText: 'Employee Id*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      validator: emailValidator,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      hintText: 'Email*',
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    CustomTextFormField(
                      validator: pwdValidator,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
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
                                  colors: [darkBlue2, lightBlue2]),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                            "Register",
                            style: body15,
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
                        style: bold,
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

// Registering user
  void onRegisterClick() async {
    if (_formKey.currentState.validate()) {
      showProgressDialog(true);
      try {
        var data = await _auth.registerWithEmailAndPassword(
            email, password, empId, firstName, lastName, vendor, url);

        if (data is PlatformException) {
          AppUtils.showToast(data.message, red, white);
          Navigator.pop(context);
          showProgressDialog(false);
        } else {
          AppUtils.showToast(registerToast, green, white);
          Navigator.pop(context);
          showProgressDialog(false);
        }
      } catch (e) {}
    }
  }
}
