import 'package:flutter/material.dart';
import 'package:food_manager_v2/widgets/profile_widget.dart';

class UserProfileAdmin extends StatefulWidget {
  final String user;
  final String fName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;

  const UserProfileAdmin(
      {Key key,
      this.user,
      this.fName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl})
      : super(key: key);

  @override
  _UserProfileAdminState createState() => _UserProfileAdminState();
}

class _UserProfileAdminState extends State<UserProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return UserProfileWidget(
      user: widget.user,
      userSurname: widget.userSurname,
      photoUrl: widget.photoUrl,
      userEmail: widget.userEmail,
      userEmpId: widget.userEmpId,
      fName: widget.fName,
    );
  }
}
