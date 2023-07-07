import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensafetyandsecurity/Complaint/createComplaint.dart';
import 'package:womensafetyandsecurity/models/complaintModel.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  var selectedStatus;
  final TextEditingController status = TextEditingController();
  List<String> StatusModes = ["Pending", "Accepted", "Processing", "Completed"];

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      status.text = documentSnapshot['status'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField(
                //   controller: status,
                //   decoration: const InputDecoration(labelText: 'Status'),
                // ),
                DropdownButton(
                  items: StatusModes.map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      )).toList(),
                  onChanged: (selected) {
                    setState(() {
                      selectedStatus = selected;
                    });
                  },
                  value: selectedStatus,
                  hint: Text("Choose Status"),
                  isExpanded: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String changeStatus = selectedStatus.toString();
                    if (changeStatus != null) {
                      await complaints.doc(documentSnapshot!.id).update({
                        "status": changeStatus,
                      });
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
    //getData1();
  }

  var docID = FirebaseAuth.instance.currentUser?.uid;

  getData() async {
    await complaints.where("city", isEqualTo: '').get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
          })
        });
  }

  final CollectionReference complaint =
      FirebaseFirestore.instance.collection('createComplaint');

  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('createComplaint');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("All Complaints"),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
            stream: complaints.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                        margin: const EdgeInsets.all(12),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(children: [
                            Text(
                              "Name: " + documentSnapshot['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 90.0, top: 10),
                              child:
                                  Text("Email: " + documentSnapshot['email']),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 185.0, top: 3),
                              child: Text("Mobile: " +
                                  documentSnapshot['mobile'].toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 155.0, top: 3),
                              child: Text(
                                  "Address: " + documentSnapshot['address']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 247.0, top: 3),
                              child: Text("City: " + documentSnapshot['city']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 137.0, top: 3),
                              child: Text("CrimeCategory: " +
                                  documentSnapshot['category']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 207.0, top: 3),
                              child:
                                  Text("Status: " + documentSnapshot['status']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _update(documentSnapshot),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ));
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        // Add new product

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
