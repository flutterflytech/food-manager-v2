import 'package:flutter/material.dart';
import 'package:food_manager_v2/bloc/meal_bloc.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/models/price_list.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../main.dart';

class QRPage extends StatefulWidget {
  final userEmpId;
  final user;
  final userFName;
  final userSurname;

  const QRPage(
      {Key key, this.userEmpId, this.user, this.userFName, this.userSurname})
      : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  // String timeStamp;
  String userJson;
  int mealType = 0;
  String mealName = 'Lunch';

  @override
  void initState() {

//    passing user QR data to JSON for future uses
    userJson =
        '{"uid": "${widget.user}","empId" : "${widget.userEmpId}", "fname":"${widget.userFName}", "surname": "${widget.userSurname}", "mealType":$mealType}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(userJson);
    PriceList dropdownValue = priceList[0];
    final mealBloc = MealBloc();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//            Select Meal dropDown
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

                          mealType = dropdownValue.foodType;
                          mealName = dropdownValue.foodName;

                          // print(mealType);
                          userJson =
                              '{"uid": "${widget.user}", "empId" : "${widget.userEmpId}", "fname":"${widget.userFName}", "surname": "${widget.userSurname}", "mealType":$mealType}';

                          print(userJson);
                          // print(dropdownValue.foodName);
                          // print(dropdownValue.price);
                        },
                        items: priceList.map<DropdownMenuItem<PriceList>>(
                            (PriceList value) {
                          return DropdownMenuItem<PriceList>(
                            value: value,
                            child: Text(value.foodName),
                          );
                        }).toList(),
                      ),
                      Card(
                        elevation:10.0,
                        child: QrImage(
                          foregroundColor: darkBlue,
                          data: userJson,
                          version: QrVersions.auto,
                          size: 350.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Show this QR Code for $mealName to Food Vendor')
                    ],
                  );
                }),
//            Generating QR code in user login
          ],
        ),
      ),
    );
  }
}
