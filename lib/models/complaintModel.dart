import 'package:cloud_firestore/cloud_firestore.dart';

class complaintModel {
  late List category;
  late List city;
  late String name;
  late String email;
  late String address;
  late String mobile;
  late String timestamp;
  late String status;

  complaintModel(
      {required this.category,
      required this.city,
      required this.name,
      required this.email,
      required this.address,
      required this.mobile,
      required this.timestamp,
      required this.status});

  complaintModel.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    //feild name should be exactly same as you given in friebase

    name = snapshot.get('name');
    address = snapshot.get('address');
    email = snapshot.get('email');
    timestamp = snapshot.get('timestamp');
    status = snapshot.get('status');
    mobile = snapshot.get('mobile');
  }
}

enum ComplaintStatus { ALL, Pending, Accepted, Processing, Completed }
