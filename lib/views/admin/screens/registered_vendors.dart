import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/style_constants.dart';

import '../../user_profile.dart';

class RegisteredVendors extends StatefulWidget {
  final String user;

  const RegisteredVendors({Key key, this.user}) : super(key: key);

  @override
  _RegisteredVendorsState createState() => _RegisteredVendorsState();
}

class _RegisteredVendorsState extends State<RegisteredVendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('account')
                .where("vendor", isEqualTo: 2)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Container(child: _userCardView(document));
                      }).toList(),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  _userCardView(document) {
    if (document['email'] == widget.user) {
      return null;
    } else
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
                      email: document['email'],
                      fName: document['fname'],
                      surname: document['surname'],
                      empId: document['empId'],
                      url: document['url'],
                    ))),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(200.0),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                        height: 60,
                        width: 60,
                        child: document['url'] == null
                            ? Image(
                                image: NetworkImage(
                                    'https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png'),
                                fit: BoxFit.fill,
                              )
                            : Image(
                                image: NetworkImage(document['url']),
                                fit: BoxFit.fill,
                              ) /*,*/
                        )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(document['empId'], style: bold15),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      document['fname'] + ' ' + document['surname'],
                      style: bold18,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(document['email'], style: font15),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
