import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:womensafetyandsecurity/models/guardianModel.dart';

class guadianProvider with ChangeNotifier {
  void addGuardianData(
      {String? id,
      String? guardian1,
      String? guardian2,
      String? guardianEmail}) async {
    await FirebaseFirestore.instance
        .collection("addGuardian")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourGuardian")
        .doc(id)
        .set({
      "ID": id,
      "guardian1": guardian1,
      "guardian2": guardian2,
      "guardianEmail": guardianEmail
    });
  }

  List<guardianModel> data = [];

  void getGuardianData() async {
    List<guardianModel> newdata = [];
    // ignore: unnecessary_cast
    QuerySnapshot value = (await FirebaseFirestore.instance
        .collection("addGuardian")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourGuardian")
        .get());

    value.docs.forEach((element) {
      guardianModel model = guardianModel(
        id: element.get("ID"),
        guardian1: element.get("guardian1"),
        guardian2: element.get("guardian2"),
        guardianEmail: element.get("guardianEmail"),
      );

      newdata.add(model);
    });
    data = newdata;
    notifyListeners();
  }

  List<guardianModel> get getGuardianDataList {
    return data;
  }

  guardianDelete(id) {
    FirebaseFirestore.instance
        .collection("addGuardian")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourGuardian")
        .doc(id)
        .delete();
        notifyListeners();
  }

  void updateGuardian(
      {String? id,
      String? guardian1,
      String? guardian2,
      String? guardianEmail}) async {
    await FirebaseFirestore.instance
        .collection("addGuardian")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourGuardian")
        .doc(id)
        .update({
      "ID": id,
      "guardian1": guardian1,
      "guardian2": guardian2,
      "guardianEmail": guardianEmail
    });
  }
}
