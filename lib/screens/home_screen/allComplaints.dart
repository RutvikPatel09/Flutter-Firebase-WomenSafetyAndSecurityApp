import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:womensafetyandsecurity/models/complaintModel.dart';
import 'package:womensafetyandsecurity/provider/chipController.dart';
import 'package:womensafetyandsecurity/reports/generateReports.dart';

import '../../provider/FirebaseController.dart';

class allComplaints extends StatefulWidget {
  const allComplaints({super.key});

  @override
  State<allComplaints> createState() => _allComplaintsState();
}

class _allComplaintsState extends State<allComplaints> {
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('createComplaint');

//dependency injection with getx
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  final ChipController chipController = Get.put(ChipController());

  //name of chips given as list
  final List<String> _chipLabel = [
    'All',
    'Pending',
    'Accepted',
    'Processing',
    'Completed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => generateReports()));
          },
          icon: Icon(Icons.save),
          label: Text("Print"),
          backgroundColor: Colors.green,
        ),
        appBar: AppBar(
          title: Text("All Complaints"),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Obx(
                  () => Wrap(
                    spacing: 20,
                    children: List<Widget>.generate(5, (int index) {
                      return ChoiceChip(
                        label: Text(_chipLabel[index]),
                        selected: chipController.selectedChip == index,
                        onSelected: (bool selected) {
                          chipController.selectedChip = selected ? index : null;
                          firestoreController.onInit();
                          firestoreController.getComplaints(ComplaintStatus
                              .values[chipController.selectedChip]);
                        },
                      );
                    }),
                  ),
                ),
                Obx(() => Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: firestoreController.complaitList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                    "${firestoreController.complaitList[index].name}"),
                                subtitle: Text(
                                    "${firestoreController.complaitList[index].address}\n"
                                    "${firestoreController.complaitList[index].mobile}\n"
                                    "${firestoreController.complaitList[index].timestamp}"),
                              ),
                            );
                          }),
                    )),
              ],
            ),
          ),
        ));
    // return Scaffold(
    //     backgroundColor: Colors.blueGrey,
    //     floatingActionButton: FloatingActionButton.extended(
    //       onPressed: () {
    //         Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(builder: (context) => generateReports()));
    //       },
    //       icon: Icon(Icons.save),
    //       label: Text("Print"),
    //       backgroundColor: Colors.green,
    //     ),
    //     appBar: AppBar(
    //       title: Text("All Complaints"),
    //       backgroundColor: Colors.green,
    //     ),
    //     body: StreamBuilder(
    //         stream: complaints.snapshots(),
    //         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    //           if (streamSnapshot.hasData) {
    //             return ListView.builder(
    //               itemCount: streamSnapshot.data!.docs.length,
    //               itemBuilder: (context, index) {
    //                 final DocumentSnapshot documentSnapshot =
    //                     streamSnapshot.data!.docs[index];

    //                 return Card(
    //                     margin: const EdgeInsets.all(12),
    //                     child: Container(
    //                       margin: const EdgeInsets.all(14),
    //                       child: Column(children: [
    //                         Text(
    //                           "Name: " + documentSnapshot['name'],
    //                           style: TextStyle(
    //                               fontSize: 20, fontWeight: FontWeight.bold),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 90.0, top: 10),
    //                           child:
    //                               Text("Email: " + documentSnapshot['email']),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 185.0, top: 3),
    //                           child: Text("Mobile: " +
    //                               documentSnapshot['mobile'].toString()),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 220.0, top: 3),
    //                           child: Text(
    //                               "Address: " + documentSnapshot['address']),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 200.0, top: 3),
    //                           child: Text("City: " + documentSnapshot['city']),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 140.0, top: 3),
    //                           child: Text("crimeCategory: " +
    //                               documentSnapshot['category']),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(right: 210.0, top: 3),
    //                           child:
    //                               Text("Status: " + documentSnapshot['status']),
    //                         ),
    //                       ]),
    //                     ));
    //               },
    //             );
    //           }
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }),

    //     // Add new product

    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
