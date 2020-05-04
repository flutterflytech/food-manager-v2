import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/services/auth.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ProgressDialog pr;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

/*  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController email;
  TextEditingController empId;
  TextEditingController password;*/

  String error = '';
  String firstName = '';
  String lastName = '';
  String empId = '';
  String email = '';
  String password = '';
  String uid = '';
  int vendor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr.style(message: 'Please wait...');

    /*  firstName = new TextEditingController();
    lastName = new TextEditingController();
    email = new TextEditingController();
    empId = new TextEditingController();
    password = new TextEditingController();*/
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
      return 'Please enter a valid email.';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters.';
    } else {
      return null;
    }
  }

  String firstNameValidator(String value) {
    if (value.length == 0) {
      return 'Please enter your first name';
    } else {
      return null;
    }
  }

  String lastNameValidator(String value) {
    if (value.length == 0) {
      return 'Please enter your last name';
    } else {
      return null;
    }
  }

  String employeeIdValidator(String value) {
    if (value.length != 6) {
      return 'This is not a valid employee ID';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
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
                    TextFormField(
                      validator: firstNameValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value) => firstName = value,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'First Name*',
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
                      validator: lastNameValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value) => lastName = value,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Last Name*',
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
                      validator: employeeIdValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value) => empId = value,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'EmployeeId*',
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
                      validator: emailValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value) => email = value,
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
                      validator: pwdValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value) => password = value,
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
                                  colors: [Colors.blue[700], Colors.blue[200]]),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenData.height * 0.02,
                    ),
                    Text("Already have an account?"),
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
                        'Login here!',
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
          email, password, empId, firstName, lastName, uid, vendor);

      if (result == null) {
        setState(() {
          error = 'Please supply a valid email';
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
          print('An error occured while sending verificartion email');
          AppUtils.showToast(
              'An error occured while sending verification email',
              Colors.red,
              Colors.white);
          print(e.message);
        }
      });
    }
  }
}
