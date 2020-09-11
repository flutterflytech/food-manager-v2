import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:food_manager_v2/models/record.dart';

class DashboardUser extends StatefulWidget {
  final String userName;
  final String userSurname;
  final String user;

  const DashboardUser({Key key, this.userName, this.userSurname, this.user}) : super(key: key);

  @override
  _DashboardUserState createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  List<charts.Series> seriesList;
  static List<charts.Series<Bookings, String>> _createRandomData(){
    final random = Random();
    final desktopSalesData = [
      Bookings('MON', random.nextInt(10)),
      Bookings('TUE', random.nextInt(10)),
      Bookings('WED', random.nextInt(10)),
      Bookings('THU', random.nextInt(10)),
      Bookings('FRI', random.nextInt(10)),
    ];

    return [
      charts.Series<Bookings, String>(
        id: 'bookings',
        domainFn: (Bookings bookings, _) => bookings.date,
        measureFn: (Bookings sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (Bookings sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      )
    ];

  }
  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }
  @override
  void initState() {
    seriesList = _createRandomData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('welcome' +' '+ widget.userName.toUpperCase() /*+' '+widget.userSurname.toUpperCase()*/),
                Container(
                  height: 200,
                  width: 200,
                  child: barChart(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
