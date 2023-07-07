import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/models/complaintModel.dart';
import 'package:womensafetyandsecurity/provider/complaintProvider.dart';

import '../../provider/guardianProvider.dart';

class ComplaintsByClient extends StatefulWidget {
  const ComplaintsByClient({super.key});

  @override
  State<ComplaintsByClient> createState() => _ComplaintsByClientState();
}

class _ComplaintsByClientState extends State<ComplaintsByClient> {
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('createComplaint');
  late complaintProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<complaintProvider>(context);
    provider.getUserData();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Complaints"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: provider.getUserDataList.length,
        itemBuilder: (context, index) {
          complaintModel data = provider.getUserDataList[index];
          var cityList = data.city;
          var cityListToString = cityList.join();
          var categoryList = data.category;
          var categoryListToString = categoryList.join();
          //print(data.address);
          return Column(
            children: [
              SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.all(12),
                child: Container(
                  margin: const EdgeInsets.all(14),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 68.0),
                      child: Text(
                        "Name: " + data.name,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 6),
                      child: Text(
                        "Mobile: " + data.mobile,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0, top: 6),
                      child: Text(
                        "City: " + cityListToString,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 68.0),
                      child: Text(
                        "Category: " + categoryListToString,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, top: 6),
                      child: Text(
                        "Address: " + data.address,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0, top: 6),
                      child: Text(
                        "Email: " + data.email,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0, top: 6),
                      child: Text(
                        "Status: " + data.status,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          );
        },
      ),
      // Add new product
    );
  }
}
