import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/widgets/custome_text_widget_user_profile.dart';

class UserProfile extends StatefulWidget {
  final String user;

  const UserProfile({Key key, this.user}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String loggedInUserEmail = '';
  String loggedInUserFirstName = '';
  String loggedInUserLastName = '';
  String loggedInUserEmployeeId = '';

  @override
  void initState() {
    getLoggedInUserData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
             Container(
                 child: Image.asset('assets/images/profile.jpeg',height: screenData.height*0.5,width: screenData.width*1.0,)
             ),
              SizedBox(
                height: screenData.height*0.03,
                width: 200,
                child: Divider(
                  color: white,
                ),
              ),
              StreamBuilder<QuerySnapshot>(

                stream: null,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomTextWidget(
                        title: 'NAME',
                        titleData: loggedInUserFirstName+' '+loggedInUserLastName,
                      ),
                      SizedBox(height: 10,),
                      CustomTextWidget(
                        title: 'JOB TITLE',
                        titleData: 'Software Trainee',
                      ),
                      SizedBox(height: 10,),
                      CustomTextWidget(
                        title: 'EMPLOYEE ID',
                        titleData: loggedInUserEmployeeId,
                      ),
                      SizedBox(height: 10,),
                      CustomTextWidget(
                        title:'EMAIL' ,
                        titleData: loggedInUserEmail,
                      ),

                    ],
                  );
                }
              ),
              SizedBox(
                height: screenData.height*0.03,
                width: 200,
                child: Divider(
                  color: white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  getLoggedInUserData() async {
    await Firestore.instance
        .collection('account')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot snapshot) {
          print(snapshot.data);
      setState(() {

        loggedInUserEmail = snapshot.data['email'];
        loggedInUserFirstName = snapshot.data['fname'];
        loggedInUserLastName = snapshot.data['surname'];
        loggedInUserEmployeeId = snapshot.data['empId'];

      });
    });
  }

}
