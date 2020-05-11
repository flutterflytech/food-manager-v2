import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Color.fromRGBO(26, 36, 33, 1.0),
        body: Column(
          children: <Widget>[
           Container(
               child: Image.asset('assets/images/profile.jpeg',height: screenData.height*0.5,width: screenData.width*1.0,)
           ),
            SizedBox(
              height: screenData.height*0.03,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            StreamBuilder<QuerySnapshot>(

              stream: null,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('NAME',style: TextStyle(color: Colors.white,fontSize: 20),),
                    Text(loggedInUserFirstName,style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w100),),
                    SizedBox(height: 10,),
                    Text('JOB TITLE',style: TextStyle(color: Colors.white,fontSize: 20),),
                    Text('Software Trainee',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w100),),
                    SizedBox(height: 10,),
                    Text('EMPLOYEE ID',style: TextStyle(color: Colors.white,fontSize: 20),),
                    Text(loggedInUserEmployeeId,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w100),),
                    SizedBox(height: 10,),
                    Text('EMAIL',style: TextStyle(color: Colors.white,fontSize: 20,),),
                    Text(loggedInUserEmail,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w100),),
                  ],
                );
              }
            ),
            SizedBox(
              height: screenData.height*0.03,
              width: 200,
              child: Divider(
                color: Colors.white,
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
