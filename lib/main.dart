import 'package:flutter/material.dart';
import 'package:food_manager_v2/services/firebase_services/auth.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/views/wrapper.dart';
import 'package:provider/provider.dart';

import 'constants/theme_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: primaryTheme,
        home: Wrapper(),
      ),
    );
  }
}
