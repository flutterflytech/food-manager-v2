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
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Food Manager',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [Colors.blue, Colors.blueAccent[100]],
                        [Colors.blue[100], Colors.blueAccent[100]],
                        [Colors.blue[300], Colors.blueAccent[400]],
                        [Colors.blue[200], Colors.blueAccent[400]]
                      ],
                      durations: [35000, 19440, 10800, 6000],
                      heightPercentages: [0.20, 0.23, 0.25, 0.30],
                      blur: MaskFilter.blur(BlurStyle.solid, 10),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    waveAmplitude: 0,
                    size: Size(
                      double.infinity,
                      double.infinity,
                    ),
                  ),
                  Container(
                    height: 500,
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 550,
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18,bottom: 18),
                            child: Text('REGISTER', style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
                          ),
                          Form(
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
                                  height: screenData.height * 0.02,
                                ),


                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: onRegisterClick,
                              child: Container(
                                height: 60,
                                width: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blueAccent
                                ),
                                child: Center(child: Text('Register', style: TextStyle(color: Colors.white,fontSize: 24),)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
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
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        user.sendEmailVerification();

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
