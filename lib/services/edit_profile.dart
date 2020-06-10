import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/utils/app_utils.dart';

class EditProfilePage extends StatefulWidget {
  final userEmail;
  final userFName;
  final userSurname;
  final userEmpId;
  final user;


  const EditProfilePage(
      {Key key, this.userEmail, this.userFName, this.userSurname, this.userEmpId, this.user})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final fNameController = TextEditingController();
  final surNameController = TextEditingController();
  final jobTitleController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fNameController.dispose();
    surNameController.dispose();
    jobTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: screenData.height * 0.07,
                  width: screenData.width * 1.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [darkBlue2, lightBlue2]),
                  ),
                  child: Center(child: Text('EDIT PROFILE', style: body20)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: widget.userFName.toUpperCase(),

                  ),
                  controller: fNameController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: widget.userSurname.toUpperCase(),
                    labelText: 'Last Name'
                  ),
                  controller: surNameController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                      hintText: widget.userFName
                  ),
                  controller: jobTitleController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                    decoration: InputDecoration(
                        enabled: false,
                        hintText:  widget.userEmpId
                    ),
                  controller: jobTitleController,

                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      enabled: false,
                      hintText:  widget.userEmail
                  ),

                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient:
                              LinearGradient(colors: [darkBlue2, lightBlue2]),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                                "Cancel",
                                style: body15,
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        update();
                      },
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient:
                              LinearGradient(colors: [lightBlue2,darkBlue2]),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                                "Save",
                                style: body15,
                              )),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  update() {
    //TODO use model class to update data instead of "{'fname': fNameController.text,'surname':surNameController.text,'jobTitle':jobTitleController.text}"
    Firestore.instance
        .collection('account')
        .document(widget.user)
        .updateData({'fname': fNameController.text,'surname':surNameController.text,'jobTitle':jobTitleController.text});
    AppUtils.showToast('Update Successful', green, white);
    Navigator.pop(context);
  }

}
