import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/bloc/edit_profile_bloc.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/models/record.dart';
import 'package:food_manager_v2/utils/app_utils.dart';

class EditProfilePage extends StatefulWidget {
  final userEmail;
  final userFName;
  final userSurname;
  final userEmpId;
  final user;

  const EditProfilePage(
      {Key key,
      this.userEmail,
      this.userFName,
      this.userSurname,
      this.userEmpId,
      this.user})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  EditProfileBLoC editProfileBLoC = EditProfileBLoC();
  String firstName;
  String lastName;
  String editJson;

  String firstNameValidator(String value) {
    if (value == null || value.trim().toString() == '') {
      return 'This Field can not be left empty';
    } else {
      return null;
    }
  }

  String lastNameValidator(String value) {
    if (value == null || value.trim().toString() == '') {
      return 'This Field can not be left empty';
    } else {
      return null;
    }
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: widget.userFName.toUpperCase(),
                        ),
                        validator: firstNameValidator,
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                            editProfileBLoC.firstNameStreamController.sink.add(firstName);
                          });
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: widget.userSurname.toUpperCase(),
                            labelText: 'Last Name'),
                        validator: lastNameValidator,
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                            editProfileBLoC.lastNameStreamController.sink.add(lastName);
                          });
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabled: false, hintText: widget.userEmpId),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabled: false, hintText: widget.userEmail),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [darkBlue2, lightBlue2]),
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
                      onTap: () {
                        if (_formKey.currentState.validate())
                          update();
                      },
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [lightBlue2, darkBlue2]),
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
    Record record = Record(userFName: firstName, userSurname: lastName);

    try {
      Firestore.instance.collection('account').document(widget.user).updateData(
          {'userFName': record.userFName, 'userSurname': record.userSurname});
      AppUtils.showToast('Update Successful', green, white);
      Navigator.pop(context);
      editProfileBLoC.firstName(firstName);
      editProfileBLoC.lastName(lastName);
    } catch (e) {}
  }
}
