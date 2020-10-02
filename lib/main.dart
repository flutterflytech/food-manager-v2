import 'package:flutter/material.dart';
import 'package:food_manager_v2/models/price_list.dart';
import 'package:food_manager_v2/services/firebase_services/auth.dart';
import 'package:food_manager_v2/models/user.dart';
import 'package:food_manager_v2/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'constants/theme_constants.dart';

void main() {
  runApp(MyApp());
}

List<PriceList> priceList = [
  PriceList(0, 50, "Lunch"),
  PriceList(1, 25, "Poha"),
  PriceList(2, 45, "Maggi"),
  PriceList(3, 35, "Beverages"),
];

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
