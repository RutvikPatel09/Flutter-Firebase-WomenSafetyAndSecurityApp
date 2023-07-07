import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier {
  void addUserData(
      {User? currentuser,
      String? userName,
      String? userEmail,
      String? userPhone,
      String? userPassword}) async {
    await FirebaseFirestore.instance
        .collection("userDetails")
        .doc(currentuser?.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userPhone": userPhone,      
      "userPassword": userPassword, 
    });
  }

 
}
