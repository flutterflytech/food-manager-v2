import 'package:flutter/material.dart';
import 'package:food_manager_v2/services/unverified_user.dart';
import 'package:food_manager_v2/views/home.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/splash_page.dart';

import 'constants/theme_constants.dart';

void main() {
  runApp(MyApp());
}

//TODO put string files inside text_constants.dart file

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Manager',
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      //home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => UnverifiedUserUI(),
        '/login': (BuildContext context) => LogInPage()
      },
    );
  }
}


