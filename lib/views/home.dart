import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/views/bottom_navigation/user_profile_page.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/bottom_navigation/users_page.dart';

class HomePage extends StatefulWidget {
  final String user;

  const HomePage({Key key, this.user}) : super(key: key);
//  final String title;
//  final String uid;
  @override
  _HomePageState createState() => _HomePageState();
}

//TODO put string files inside text_constants.dart file
class _HomePageState extends State<HomePage> {
  String loggedInUserUid = '';
  String loggedInUserFname = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Manager'),
        centerTitle: true,
        actions: <Widget>[
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.home,
                    size: 30,
                    color: Colors.blue[300],
                  ),
                  tooltip: 'Home',
                  onPressed: () {

                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.utensils,
                    size: 30,
                    color: Colors.blue[300],
                  ),
                  tooltip: 'Vendor',
                  onPressed: () {
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.users,
                    size: 30,
                    color: Colors.blue[300],
                  ),
                  tooltip: 'Users',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UsersPage()));
                  }),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.houseUser,
                    size: 30,
                    color: Colors.blue[300],
                  ),
                  tooltip: 'Profile',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile(user:widget.user,)));
                  }),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome'+' '+loggedInUserFname),

                  Text('Press icon'),
                  Icon(FontAwesomeIcons.users,),
                  Text('To see registered users')

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/* _getVerifiedUserData(){
    return[
      Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Welcome Verified User'),
              IconButton(
                onPressed: (){
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
      )
    ];
  }

  _getUnverifiedUserData(){

    return[
      Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Resend Email'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _sendMailAgain,
              ),
              RaisedButton(

                color:Theme.of(context).primaryColor,
                child: Text('Already Verified'),
                textColor: Colors.white,
                onPressed: _checkVerificationStatus,

              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                },
              )
            ],
          ),
        ),
      )
    ];

  }

  _sendMailAgain() async{

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification().then((_) {

        AppUtils.showToast('Email verification link send successfuly.',
            Colors.green, Colors.white);
      }).catchError((error) {

        print(error.message);
      });
    } catch (e) {

      print("An error occured while trying to send email verification");
      AppUtils.showToast(
          'An error occured while trying to send email verification',
          Colors.red,
          Colors.white);
      print(e.message);
    }

  }

  _checkVerificationStatus() async{
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
                Colors.red, Colors.white);
          }
        });
      });
    } catch (e) {

      print('An error occured while trying to check email is verified or not!');
      AppUtils.showToast(
          'An error occured while trying to check email is verified or not!',
          Colors.red,
          Colors.white);
      print(e.message);
    }
  }
*/
  getLoggedInUserData() async {
    await Firestore.instance
        .collection('account')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot snapshot) {

          print(snapshot.data);
      setState(() {
        loggedInUserUid = snapshot.data['uid'];
        loggedInUserFname = snapshot.data['fname'];

      });
    });
  }
}
