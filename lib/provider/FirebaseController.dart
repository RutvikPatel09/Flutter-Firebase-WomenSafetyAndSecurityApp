import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:womensafetyandsecurity/models/complaintModel.dart';
import 'package:womensafetyandsecurity/provider/chipController.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FirestoreController extends GetxController {
  //referance to firestore collection here laptop is collection name
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('createComplaint');

  var complaitList = <complaintModel>[].obs;

  //dependency injection with getx
  ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    //binding to stream so that we can listen to realtime cahnges

    complaitList.bindStream(
        getComplaints(ComplaintStatus.values[_chipController.selectedChip]));
    super.onInit();
  }

// this fuction retuns stream of laptop lsit from firestore

  Stream<List<complaintModel>> getComplaints(ComplaintStatus status) {
    //using enum class LaptopBrand in switch case
    switch (status) {
      case ComplaintStatus.ALL:
        Stream<QuerySnapshot> stream = reference.snapshots();

        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return complaintModel.fromDocumentSnapshot(snap);
            }).toList());

      case ComplaintStatus.Pending:
        Stream<QuerySnapshot> stream =
            reference.where('status', isEqualTo: 'Pending').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return complaintModel.fromDocumentSnapshot(snap);
            }).toList());

      case ComplaintStatus.Accepted:
        Stream<QuerySnapshot> stream =
            reference.where('status', isEqualTo: 'Accepted').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return complaintModel.fromDocumentSnapshot(snap);
            }).toList());

      case ComplaintStatus.Processing:
        Stream<QuerySnapshot> stream =
            reference.where('status', isEqualTo: 'Processing').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return complaintModel.fromDocumentSnapshot(snap);
            }).toList());

      case ComplaintStatus.Completed:
        Stream<QuerySnapshot> stream =
            reference.where('status', isEqualTo: 'Completed').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return complaintModel.fromDocumentSnapshot(snap);
            }).toList());
    }
  }
}
