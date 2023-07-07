import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class policeProvider with ChangeNotifier {
  void addPolice(
      {String? district,
      String? area,
      String? type,
      String? email,
      String? address,
      String? mobile,
      String? name,
      String? poilceID}) async {
    await FirebaseFirestore.instance
        .collection("addPolice")
        .doc(area)
        .set({
      "Address": address,
      "Area": area,
      "policeName":name,
      "Email": email,
      "Type": type,
      "policeMobile": mobile,
      "district": district,
      "policeID": poilceID
    });
  }

  

}
