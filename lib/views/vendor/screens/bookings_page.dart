import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/bloc/payment_bloc.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/views/vendor/screens/loading_shimmer.dart';

class Bookings extends StatefulWidget {
  final String user;

  const Bookings({Key key, this.user}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final paymentStatus = PaymentStatus();
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
    ));
  }

  _userCardView(document) {
    var screenData = MediaQuery.of(context).size;

    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: screenData.width * 0.7,
                  child: Row(
                    children: [
                      Text(
                          document['userFName'].toUpperCase() +
                              ' ' +
                              document['userLName'].toUpperCase(),
                          style: body22Black),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.rupeeSign,
                            size: 20,
                          ),
                          Text(
                            document['mealPrice'].toString(),
                            style: font22,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: screenData.width * 0.7,
                  child: Row(
                    children: <Widget>[
                      Text(document['mealName'], style: body30),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        document['timeStamp'],
                        style: font22,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                IconButton(
                  icon: document['paymentStatus'] == false
                      ? Icon(
                          FontAwesomeIcons.timesCircle,
                          color: Colors.red,
                          size: 35,
                        )
                      : Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.green,
                          size: 35,
                        ),
                  tooltip: 'Payment',
                  onPressed: () {
                    openPopup(context, document);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  openPopup(BuildContext context, document) {
    return showDialog(
        context: context,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    document['paymentStatus'] == false
                        ? 'Confirm Payment'
                        : 'Payment Status',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                document['paymentStatus'] == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<bool>(
                            stream: paymentStatus.choiceStream,
                            builder: (context, snapshot) {
                              return IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.checkCircle,
                                  color: Colors.green,
                                  size: 35,
                                ),
                                onPressed: () {
                                  paymentStatus.paymentConformation(document['bookingId']);
                                  print(paymentStatus);
                                  Navigator.pop(context);
                                },
                              );
                            }
                          ),
                          // SizedBox(width: 20.0,),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.timesCircle,
                              color: Colors.red,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.green,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          // SizedBox(width: 20.0,),
                        ],
                      )
              ],
            ),
          ),
        ));
  }
}
