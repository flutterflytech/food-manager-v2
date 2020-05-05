import 'package:flutter/material.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/splash_page.dart';

import 'constants/theme_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Manager',
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: SplashPage() ,
    );
  }
}


