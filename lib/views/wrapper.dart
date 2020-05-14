import 'package:flutter/material.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/views/bottom_navigation/dashboard_page.dart';
import 'package:food_manager_v2/views/home.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return LogInPage();
    } else {
      return HomePage(user: user.uid,);
    }
  }
}
