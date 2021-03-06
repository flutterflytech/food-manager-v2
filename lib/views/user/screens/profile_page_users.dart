import 'package:flutter/material.dart';
import 'package:food_manager_v2/widgets/all_profile_widget.dart';

class UserProfileUsers extends StatefulWidget {
  final String user;
  final String fName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;

  const UserProfileUsers(
      {Key key,
      this.user,
      this.fName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl})
      : super(key: key);

  @override
  _UserProfileUsersState createState() => _UserProfileUsersState();
}

class _UserProfileUsersState extends State<UserProfileUsers> {
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
