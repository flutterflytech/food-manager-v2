import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/bloc/meal_bloc.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/models/price_list.dart';
import 'package:food_manager_v2/services/firebase_services/logout_service.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/views/vendor/screens/bookings_page.dart';
import 'package:food_manager_v2/views/vendor/screens/scan_qr_page.dart';
import 'package:food_manager_v2/main.dart';
import 'package:food_manager_v2/widgets/all_profile_widget.dart';

class HomePageVendor extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;
  final String user;
  final Function(String) onUrlChange;

  const HomePageVendor(
      {Key key,
      this.userName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl,
      this.user,
      this.onUrlChange})
      : super(key: key);

  @override
  _HomePageVendorState createState() => _HomePageVendorState();
}

class _HomePageVendorState extends State<HomePageVendor> {
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  LogoutService logoutService = LogoutService();
  String photoUrl;

  @override
  void initState() {
    super.initState();
    photoUrl = widget.photoUrl;
  }

  getBody(int position) {
    switch (position) {
      case 0:
        return ScanQr(
          user: widget.user,
          userFName: widget.userName,
          userSurname: widget.userSurname,
        );
      case 1:
        return Bookings(
          user: widget.user,
        );
      case 2:
        return UserProfileWidget(
          user: widget.user,
          fName: widget.userName,
          onUrlChange: (url) {
            photoUrl = url;
          },
          photoUrl: photoUrl,
          userEmail: widget.userEmail,
          userEmpId: widget.userEmpId,
          userSurname: widget.userSurname,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(40, 20),
                bottomRight: Radius.elliptical(40, 20))),
        title: Text('Food Manager'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              openDialog(context);
            },
            icon: Icon(FontAwesomeIcons.rupeeSign),
            tooltip: 'Set Price',
          ),
          IconButton(
            onPressed: () async {
              try {
                await logoutService.logoutService();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInPage(),
                  ),
                );
              } catch (e) {
                print(" ==============> error <========" + e.toString());
              }
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        elevation: 0,
        currentIndex: _currentIndex,
        items: [
//          dashboard
//           BottomNavigationBarItem(
//               icon: Icon(
//                 FontAwesomeIcons.home,
//                 size: 30,
//                 color: lightBlue1,
//               ),
//               title: Text(
//                 'Home',
//                 style: bold,
//               )),
//       Scan QR
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.qrcode,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Scan QR', style: bold)),
//        Bookings
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bootstrap,
                size: 30,
                color: lightBlue1,
              ),
              title: Text('Bookings', style: bold)),
//          Profile
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
  }

  openDialog(BuildContext context) {
    PriceList dropdownValue = priceList[0];
    final mealBloc = MealBloc();
    return showDialog(
        context: context,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            height: 200,
            width: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    'Price List',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                StreamBuilder<PriceList>(
                  stream: mealBloc.choiceStream,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        DropdownButton<PriceList>(
                          value: dropdownValue,
                          icon: Icon(Icons.expand_more),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (PriceList newValue) {
                            dropdownValue = newValue;
                            mealBloc.choiceSink.add(dropdownValue);
                          },
                          items: priceList.map<DropdownMenuItem<PriceList>>(
                              (PriceList value) {
                            return DropdownMenuItem<PriceList>(
                              value: value,
                              child: Text(value.foodName),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/price-tag.png',
                                height: 70,
                                width: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Text(dropdownValue.price.toString()),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
