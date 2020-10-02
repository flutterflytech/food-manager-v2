import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/style_constants.dart';

import '../../../widgets/user_profile.dart';

class RegisteredAdmins extends StatefulWidget {
  final String user;
  final int userType;
  final String appBarTitle;

  const RegisteredAdmins({Key key, this.user, this.userType, this.appBarTitle})
      : super(key: key);

  @override
  _RegisteredAdminsState createState() => _RegisteredAdminsState();
}

class _RegisteredAdminsState extends State<RegisteredAdmins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(80, 40),
                bottomRight: Radius.elliptical(80, 40))),
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
              child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('account')
                .where("vendor", isEqualTo: widget.userType)
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
          )),
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
                        child:
                            document['url'] == null || document['url'].isEmpty
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
