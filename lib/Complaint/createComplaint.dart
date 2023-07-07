import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/provider/complaintProvider.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';
import 'package:womensafetyandsecurity/screens/crimeCategory.dart';

class createComplaint extends StatefulWidget {
  const createComplaint({super.key});

  @override
  State<createComplaint> createState() => _createComplaintState();
}

class _createComplaintState extends State<createComplaint> {
  final TextEditingController address = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController status = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  var selectedType, selectedCityType;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("addPolice");
  CollectionReference collectionReference2 =
      FirebaseFirestore.instance.collection("crimeCategory");

  // Future<void> getListData() async {
  //   QuerySnapshot querySnapshot = await collectionReference.get();
  //   QuerySnapshot querySnapshot2 = await collectionReference2.get();
  //   final city = querySnapshot.docs.map((data) => data['City']).toList();
  //   final crimeCategoryData =
  //       querySnapshot2.docs.map((data) => data['categoryName']).toList();
  //   //print(city + crimeCategory);
  // }

  // List<String> data = <String>["Data1", "Data2"];

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    QuerySnapshot querySnapshot1 = await collectionReference2.get();
    final crimeCategoryData =
        querySnapshot1.docs.map((data) => data['categoryName']).toList();

    QuerySnapshot querySnapshot2 = await collectionReference.get();
    final city = querySnapshot2.docs.map((data) => data['Area']).toList();

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
                DropdownButton(
                  items: crimeCategoryData
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      selectedType = selectedValue;
                    });
                  },
                  value: selectedType,
                  isExpanded: false,
                  hint: Text("Choose Crime Category"),
                ),
                DropdownButton(
                  items: city
                      .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      selectedCityType = selectedValue;
                    });
                  },
                  value: selectedCityType,
                  isExpanded: false,
                  hint: Text("Choose Area"),
                ),
                TextFormField(
                  controller: address,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(labelText: "Address"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Address";
                    } else {
                      null;
                    }
                  },
                ),
                TextFormField(
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: "Phone Number"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Correct Phone number";
                      } else {
                        null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    final String Address = address.text;
                    final String Mobile = mobile.text;
                    final String crimeCategory = selectedType.toString();
                    final String city = selectedCityType.toString();
                    DateTime currentDate = DateTime.now();
                    Timestamp myTimeStamp = Timestamp.fromDate(currentDate);
                    DateTime myDateTime = myTimeStamp.toDate();
                    final User? user = auth.currentUser;
                    final name = user?.displayName;
                    final email = user?.email;
                    final String status = "Pending";
                    // if (Address != null) {
                    //   complaintProvider provider =
                    //       Provider.of(context, listen: false);

                    //   provider.createComplaint(
                    //       category: crimeCategory,
                    //       city: city,
                    //       name: name,
                    //       email: email,
                    //       address: Address,
                    //       mobile: Mobile,
                    //       status: status,
                    //       timestamp: myDateTime.toString());
                    //   Navigator.of(context).pop();
                    // }
                    if (Address.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Address is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (Mobile.isEmpty || Mobile.length != 10) {
                      var snackbar = SnackBar(
                          content: Text('Enter Correct Phone Number!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else {
                      complaintProvider provider =
                          Provider.of(context, listen: false);

                      provider.createComplaint(
                          category: crimeCategory,
                          city: city,
                          name: name,
                          email: email,
                          address: Address,
                          mobile: Mobile,
                          status: status,
                          timestamp: myDateTime.toString());
                      var snackbar = SnackBar(
                          content: Text('Comlaint Send Successfully...'));
                      address.text = '';
                      mobile.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Complaint"),
          backgroundColor: Colors.green,
        ),
        // body: StreamBuilder(
        //     stream: _crimeCategory.snapshots(),
        //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        //       if (streamSnapshot.hasData) {
        //         return ListView.builder(
        //           itemCount: streamSnapshot.data!.docs.length,
        //           itemBuilder: (context, index) {
        //             final DocumentSnapshot documentSnapshot =
        //                 streamSnapshot.data!.docs[index];
        //             return Card(
        //               margin: const EdgeInsets.all(14),
        //               child: ListTile(
        //                 title: Text(documentSnapshot['categoryName']),
        //                 trailing: SizedBox(
        //                   width: 100,
        //                   child: Row(
        //                     children: [
        //                       IconButton(
        //                         icon: const Icon(Icons.edit),
        //                         onPressed: () => _update(documentSnapshot),
        //                       ),
        //                       IconButton(
        //                           icon: const Icon(Icons.delete),
        //                           onPressed: () =>
        //                               _delete(documentSnapshot.id)),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       }
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }),
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
