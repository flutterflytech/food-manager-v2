import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/text_constants.dart';
import 'package:food_manager_v2/google.dart';
import 'package:food_manager_v2/services/firebase_services/auth.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/views/unverified_user.dart';
import 'package:food_manager_v2/views/forgot_password_page.dart';
import 'package:food_manager_v2/views/register_page.dart';
import 'package:food_manager_v2/widgets/custom_text_form_filed.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LogInPage extends StatefulWidget {
  final String user;

  const LogInPage({Key key, this.user}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthService _auth = AuthService();

  Map userData;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password;
  ProgressDialog pr;
  bool obscure = true;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  String loggedInEmail;

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
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              height: 180,
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
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
                  height: screenData.height * 0.7,
                  width: screenData.width * 1.0,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: screenData.height * 0.1,
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: screenData.height * 0.2,
                                // ),
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
                                  height: screenData.height * 0.02,
                                ),
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
                                        borderSide: BorderSide(
                                            color: lightBlue2, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: darkBlue2, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(50.0))),
                                ),
                                SizedBox(
                                  height: screenData.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Text(forgotPassword),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPassword()));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenData.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _onLogInClick,
                          child: Container(
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blueAccent),
                            child: Center(
                                child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: screenData.height * 0.01,
                        ),
                        Text('Or login using'),
                        SizedBox(
                          height: screenData.height * 0.01,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(color: Colors.cyanAccent),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: Text('Sign Up',
                                  style: TextStyle(color: Colors.cyanAccent)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  _onLogInClick() async {
    if (_formKey.currentState.validate()) {
      try {
        showProgressDialog(true);
        dynamic result =
            await _auth.signInWithEmailAndPassword(email, password);
        if (result is PlatformException) {
          AppUtils.showToast(result.message, red, white);
          showProgressDialog(false);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UnverifiedUserUI(),
            ),
          );
        }
      } catch (e) {
        showProgressDialog(false);
      }
    }
  }
}
