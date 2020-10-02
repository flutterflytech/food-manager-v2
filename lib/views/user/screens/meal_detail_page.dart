import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/vendor/screens/loading_shimmer.dart';

class MealPage extends StatefulWidget {
  final user;

  const MealPage({Key key, this.user}) : super(key: key);

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  String mealName;

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
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Container(child: _userCardView(document));
                  }).toList(),
                ),
              );
          }
        },
      ),
    );
  }

  _userCardView(document) {
    var screenData = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),topRight: Radius.circular(30.0))
      ),
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
                    // width: screenData.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['mealName'],
                          style: body20Black,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(document['timeStamp'], style: font15),
                        Text(document['bookingId'], ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // width: screenData.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'From : ' + document['vendorFName'],
                          style: body20Black,
                        ),
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
                                  Text(document['mealPrice'].toString(),
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
