import 'package:flutter/material.dart';
import 'package:food_manager_v2/widgets/profile_widget.dart';

class UserProfileVendor extends StatefulWidget {
  final String user;
  final String fName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;

  const UserProfileVendor(
      {Key key,
      this.user,
      this.fName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl})
      : super(key: key);

  @override
  _UserProfileVendorState createState() => _UserProfileVendorState();
}

class _UserProfileVendorState extends State<UserProfileVendor> {
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
