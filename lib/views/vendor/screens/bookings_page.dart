import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/style_constants.dart';

import '../../user_profile.dart';

class Bookings extends StatefulWidget {
  final String user;

  const Bookings({Key key, this.user}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('bookings')
          .where("vendorId", isEqualTo: widget.user)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
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
    ));
  }

  _userCardView(document) {

      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
//                     Todo click page references
                    ))),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(document['userId'], style: bold15),
                    SizedBox(
                      height: 5,
                    ),
                    Text(document['bookingId'], style: font15),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
