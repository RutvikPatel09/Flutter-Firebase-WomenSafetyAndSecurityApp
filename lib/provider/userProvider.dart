import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:womensafetyandsecurity/models/UserModel.dart';

class UserProvider with ChangeNotifier {
  void addUserData(
      {User? currentuser,
      String? userName,
      String? userEmail,
      String? userImage}) async {
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(currentuser?.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUid": currentuser!.uid
    });
  }

  late UserModel currentData;
  void getUserData() async {
    List<UserModel> newdata = [];
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      data = newdata;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }

  List<UserModel> data = [];

  List<UserModel> get getUserDataList {
    return data;
  }
}
