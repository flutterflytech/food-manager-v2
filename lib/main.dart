import 'package:flutter/material.dart';

//import 'package:food_manager_v2/models/user_model.dart';
import 'package:food_manager_v2/services/auth.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/views/home.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/splash_page.dart';
import 'package:food_manager_v2/views/wrapper.dart';
import 'package:provider/provider.dart';

import 'constants/theme_constants.dart';

void main() {
  runApp(MyApp());
}

//TODO put string files inside text_constants.dart file

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
//        title: 'Food Manager',
        debugShowCheckedModeBanner: false,
//        theme: primaryTheme,
        home: Wrapper(),
//        routes: <String, WidgetBuilder>{
//          '/home': (BuildContext context) => HomePage(),
//          '/login': (BuildContext context) => LogInPage()
//        },
      ),
    );
  }
}
