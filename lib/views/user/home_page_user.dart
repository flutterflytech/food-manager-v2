import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/services/firebase_services/logout_service.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/user/screens/meal_detail_page.dart';
import 'package:food_manager_v2/views/user/screens/payment_detail_page.dart';
import 'package:food_manager_v2/views/user/screens/generate_qr_page.dart';
import 'package:food_manager_v2/views/user/screens/profile_page_users.dart';

class HomePageUser extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;
  final int userType;
  final String user;

  const HomePageUser(
      {Key key,
      this.userName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl,
      this.userType,
      this.user})
      : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  LogoutService logoutService = LogoutService();
  StreamController<int> _paymentFilterStreamController =
      StreamController<int>();
  StreamController<int> _bottomTabController = StreamController<int>();


  @override
  void dispose() {
    _paymentFilterStreamController.close();
    _bottomTabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _bottomTabController.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(40, 20),
                      bottomRight: Radius.elliptical(40, 20))),
              title: Text('Food Manager'),
              centerTitle: true,
              actions: <Widget>[
                snapshot.data == 0
                    ? PopupMenuButton<String>(
                        icon: Icon(FontAwesomeIcons.filter),
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {
                            'All',
                            'Paid',
                            'Due',
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    : Container(),
                IconButton(
                  onPressed: () {
                    try{
                      logoutService.logoutService();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInPage(),
                        ),
                      );
                    }catch(e){

                    }

                  },
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            body: getChildWidgetOnBottomBarClicked(snapshot.data),
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              elevation: 0,
              currentIndex: snapshot.data,
              items: [
                // BottomNavigationBarItem(
                //     icon: Icon(
                //       FontAwesomeIcons.home,
                //       size: 30,
                //       color: lightBlue1,
                //     ),
                //     title: Text(
                //       'Home',
                //       style: bold,
                //     )),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.moneyBill,
                      size: 30,
                      color: lightBlue1,
                    ),
                    title: Text('Payment', style: bold)),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.pizzaSlice,
                      size: 30,
                      color: lightBlue1,
                    ),
                    title: Text('Meals', style: bold)),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.qrcode,
                      size: 30,
                      color: lightBlue1,
                    ),
                    title: Text('QR Code', style: bold)),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.houseUser,
                      size: 30,
                      color: lightBlue1,
                    ),
                    title: Text('Profile', style: bold)),
              ],
            ),
          );
        });
  }

  void onTabTapped(int index) {
    _bottomTabController.sink.add(index);
  }


  void handleClick(String value) {
    switch (value) {
      case 'All':
        _paymentFilterStreamController.sink.add(0);
        break;
      case 'Paid':
        _paymentFilterStreamController.sink.add(1);
        break;
      case 'Due':
        _paymentFilterStreamController.sink.add(2);
        break;
    }
  }

  getChildWidgetOnBottomBarClicked(int position) {
    switch (position) {
      // case 0:
      //   return DashboardUser(
      //     user: widget.user,
      //     userName: widget.userName,
      //     userSurname: widget.userSurname,
      //   );
      case 0:
        if (!_paymentFilterStreamController.isClosed) {
          _paymentFilterStreamController.close();
        }
        _paymentFilterStreamController = StreamController<int>();
        return StreamBuilder<Object>(
            stream: _paymentFilterStreamController.stream,
            initialData: 0,
            builder: (context, snapshot) {
              return PaymentPage(
                user: widget.user,
                filterState: snapshot.data,
              );
            });
      case 1:
        return MealPage(
          user: widget.user,
        );
      case 2:
        return QRPage(
          user: widget.user,
          userEmpId: widget.userEmpId,
          userFName: widget.userName,
          userSurname: widget.userSurname,
        );
      case 3:
        return UserProfileUsers(
          user: widget.user,
          fName: widget.userName,
          photoUrl: widget.photoUrl,
          userEmail: widget.userEmail,
          userEmpId: widget.userEmpId,
          userSurname: widget.userSurname,
        );
    }
  }
}
