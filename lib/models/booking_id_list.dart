
import 'package:cloud_firestore/cloud_firestore.dart';


class BookingId {
  final List<dynamic> id;
  final DocumentReference reference;

  BookingId.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['booking_list'] != null),
        id = map['fname'];


  BookingId.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}
