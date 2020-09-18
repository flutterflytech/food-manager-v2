//Put all your FireBase related utils static methods here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

 getCurrentFireBaseServerDate() {
  Timestamp timestamp = Timestamp.now();
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  var formatter = new DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}
