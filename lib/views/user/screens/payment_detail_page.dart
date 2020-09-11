import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/models/booking_list.dart';
import 'package:food_manager_v2/views/user/screens/meal_detail_page.dart';
import 'package:food_manager_v2/views/vendor/screens/loading_shimmer.dart';

import '../../user_profile.dart';

class PaymentPage extends StatefulWidget {
  final user;
  final filterState;

  const PaymentPage({Key key, this.user, this.filterState}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('bookings')
            .where("userId", isEqualTo: widget.user)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingListPage();
            default:
              {
                List<BookingList> bookingList = snapshot.data.documents
                    .map((e) => BookingList.fromJson(e.data))
                    .toList();
                switch (widget.filterState) {
                  case 0:
                    break;
                  case 1:
                    bookingList = bookingList.where((element) => element.paymentStatus).toList();
                    break;
                  case 2:
                    bookingList = bookingList.where((element) => !element.paymentStatus).toList();
                    break;
                }
                print('Call recieved');

                // List<BookingList> filteredUnpaid = bookingList
                //     .where((booking) => !booking.paymentStatus)
                //     .toList();
                // List<BookingList> filteredPaid = bookingList
                //     .where((booking) => booking.paymentStatus)
                //     .toList();

                // List<BookingList> filteredList = filtered.toList();
                // print(filteredUnpaid.toString());
                // print(filteredPaid.toString());
                return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: new ListView(
                        children: bookingList.map((BookingList document) {
                      return Container(child: _userCardView(document));
                    }).toList()));
              }
          }
        },
      ),
    );
  }

  _userCardView(BookingList document) {
    var screenData = MediaQuery.of(context).size;

    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: screenData.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // width: screenData.width*0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.mealName,
                          style: body20Black,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'From : ' + document.vendorName,
                          style: body20Black,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      // width: screenData.width*0.85,
                      child: document.paymentStatus == false
                          ? Image.asset(
                              'assets/images/unpaid.png',
                              height: 40,
                              width: 40,
                            )
                          : Image.asset(
                              'assets/images/paid.png',
                              height: 40,
                              width: 40,
                            )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // width: screenData.width*0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(document.timestamp, style: font15),
                        // Expanded(child: Container(),),

                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7.0),
                              child: Icon(
                                FontAwesomeIcons.moneyBill,
                                size: 55,
                                color: Colors.blue[100],
                              ),
                            ),
                            Positioned(
                              bottom: 13.0,
                              right: 08.0,
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.rupeeSign,
                                    size: 20.0,
                                  ),
                                  Text(document.mealPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
