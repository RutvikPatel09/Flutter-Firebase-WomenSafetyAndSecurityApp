import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:womensafetyandsecurity/provider/addPoliceProvider.dart';

class addPolice extends StatefulWidget {
  const addPolice({super.key});

  @override
  State<addPolice> createState() => _addPoliceState();
}

class _addPoliceState extends State<addPolice> {
  final TextEditingController policeName = TextEditingController();
  final TextEditingController policeMobileNo = TextEditingController();
  final TextEditingController Type = TextEditingController();
  final TextEditingController Address = TextEditingController();
  final TextEditingController Area = TextEditingController();
  final TextEditingController District = TextEditingController();
  final TextEditingController Email = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
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
                TextField(
                  controller: policeName,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Name'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                ),
                TextFormField(
                  controller: policeMobileNo,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Phone Number"),
                ),
                TextField(
                  controller: Type,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Type'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                ),
                TextField(
                  controller: Address,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: Area,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Area'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                ),
                TextField(
                  controller: District,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'District'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                ),
                TextField(
                  controller: Email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = policeName.text;
                    final String number = policeMobileNo.text;
                    final String type = Type.text;
                    final String address = Address.text;
                    final String area = Area.text;
                    final String district = District.text;
                    final String email = Email.text;
                    const uuid = Uuid();
                    final String policeID = uuid.v1();
                    Random random = new Random();
                    int randomNumber = random.nextInt(5000);
                    //final String ID = name.toString() + randomNum.toString();
                    //print("Hey" + ID);

                    if (name.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Name is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (number.isEmpty || number.length != 10) {
                      var snackbar = SnackBar(
                          content: Text('Enter Correct Phone Number!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (type.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Type is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (address.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Address is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (area.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Area is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (district.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('District is empty!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (email.isEmpty ||
                        !RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                            .hasMatch(email)) {
                      var snackbar = SnackBar(
                          content: Text('Please Enter Correct Email!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else {
                      policeProvider provider =
                          Provider.of(context, listen: false);
                      provider.addPolice(
                          poilceID: area + randomNumber.toString(),
                          name: name,
                          address: address,
                          type: type,
                          area: area,
                          district: district,
                          email: email,
                          mobile: number);
                            var snackbar = SnackBar(
                          content: Text('Police Added Successfully...'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar); 
                      Navigator.of(context).pop();
                      // await _ADDPolice.add({
                      //   "policeName": name,
                      //   "policeID": randomNumber.toString(),
                      //   "policeMobileNo": number,
                      //   "Type": type,
                      //   "Address": address,
                      //   "City": city,
                      //   "District": district,
                      //   "Email": email
                      // });
                      policeName.text = '';
                      clearText();
                      Type.text = '';
                      Address.text = '';
                      Area.text = '';
                      District.text = '';
                      Email.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  void clearText() {
    policeMobileNo.clear();
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      policeName.text = documentSnapshot['policeName'];
      policeMobileNo.text = documentSnapshot['policeMobileNo'];
      Type.text = documentSnapshot['Type'];
      Address.text = documentSnapshot['Address'];
      Area.text = documentSnapshot['City'];
      District.text = documentSnapshot['District'];
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
                TextField(
                  controller: policeName,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: policeMobileNo,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Phone Number"),
                ),
                TextField(
                  controller: Type,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: Address,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: Area,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: District,
                  decoration: const InputDecoration(labelText: 'District'),
                ),
                TextField(
                  controller: Email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = policeName.text;
                    final String number = policeMobileNo.text;
                    final String type = Type.text;
                    final String address = Address.text;
                    final String city = Area.text;
                    final String district = District.text;
                    final String email = Email.text;
                    if (policeName != null &&
                        policeMobileNo != null &&
                        Type != null &&
                        Address != null &&
                        Area != null &&
                        District != null &&
                        Email != null) {
                      await _ADDPolice.doc(documentSnapshot!.id).update({
                        "policeName": name,
                        "policeMobileNo": number,
                        "Type": type,
                        "Address": address,
                        "City": city,
                        "District": district,
                        "Email": email
                      });
                      policeName.text = '';
                      Type.text = '';
                      Address.text = '';
                      Area.text = '';
                      District.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _ADDPolice.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted Police!')));
  }

  final CollectionReference _ADDPolice =
      FirebaseFirestore.instance.collection('addPolice');

  getData() {
    const uuid = Uuid();
    final String policeID = uuid.v1();
    Random random = new Random();
    int randomNumber = random.nextInt(5000);
    print(randomNumber);
    print(policeID);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Add Police"),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
            stream: _ADDPolice.snapshots(),
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
                          margin: const EdgeInsets.all(14),

                          // child: ListTile(
                          //   title: Text(
                          //     documentSnapshot['policeID'],
                          //   ),
                          child: Column(children: [
                            Text(
                              "ID: " + documentSnapshot['policeID'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 160.0, top: 15),
                              child: Text("PoliceName: " +
                                  documentSnapshot['policeName']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 190.0, top: 3),
                              child: Text("Phone: " +
                                  documentSnapshot['policeMobile'].toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 253.0, top: 3),
                              child: Text("Type: " + documentSnapshot['Type']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 230.0, top: 3),
                              child: Text(
                                  "Address: " + documentSnapshot['Address']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 200.0, top: 3),
                              child: Text("Area: " + documentSnapshot['Area']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 200.0, top: 3),
                              child: Text(
                                  "District: " + documentSnapshot['district']),
                            ),
                            SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _update(documentSnapshot),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                         showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          child: AlertDialog(
                                            title: Text(
                                                "Are You Sure You Want to Delete the Category?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("NO")),
                                              TextButton(
                                                  onPressed: () {
                                                    _delete(
                                                        documentSnapshot.id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("YES"))
                                            ],
                                          ),
                                        );
                                      }))
                                ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
