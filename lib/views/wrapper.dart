import 'package:flutter/material.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/services/unverified_user.dart';
import 'file:///C:/Users/NEERAJ/Documents/office-flutter/food-manager-v2/lib/views/admin/screens/dashboard_page.dart';
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
      return UnverifiedUserUI(user: user.uid,);
    }
  }
}
