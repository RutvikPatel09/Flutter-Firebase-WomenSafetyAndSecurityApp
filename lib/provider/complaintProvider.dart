import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:womensafetyandsecurity/models/complaintModel.dart';

class complaintProvider with ChangeNotifier {
  void createComplaint(
      {String? category,
      String? city,
      String? name,
      String? email,
      String? address,
      String? mobile,
      String? timestamp,
      String? status}) async {
    await FirebaseFirestore.instance
        .collection("createComplaint")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "category": category,
      "city": city,
      "name": name,
      "email": email,
      "address": address,
      "mobile": mobile,
      "timestamp": timestamp,
      "status": status
    });
  }

  late complaintModel currentData;
  void getUserData() async {
    List<complaintModel> newdata = [];
    complaintModel complaintmodel;
    var value = await FirebaseFirestore.instance
        .collection("createComplaint")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (value.exists) {
      complaintmodel = complaintModel(
          //category: value.get("category"),
          //city: value.get("city"),
          address: value.get("address"),
          email: value.get("email"),
          timestamp: value.get("timestamp"),
          mobile: value.get("mobile"),
          status: value.get("status"),
          name: value.get("name"),
          city: [value.get("city")],
          category: [value.get("category")]);
      currentData = complaintmodel;
         newdata.add(complaintmodel);
   
      data = newdata;
      notifyListeners();
    }
  }

  complaintModel get currentUserData {
    return currentData;
  }

  List<complaintModel> data = [];

  List<complaintModel> get getUserDataList {
    return data;
  }
}
