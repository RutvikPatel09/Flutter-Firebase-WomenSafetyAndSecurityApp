import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  late FirebaseFirestore firebaseFirestore;

  initialize() {
    firebaseFirestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];

    try {
      querySnapshot = await firebaseFirestore
          .collection('crimeCategory')
          .orderBy('crimeCategory')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "categoryName": doc["categoryName"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
    //throw Exception("Error on server");
  }
}
