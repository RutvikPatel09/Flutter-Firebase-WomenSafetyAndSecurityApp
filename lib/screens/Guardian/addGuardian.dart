import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/models/guardianModel.dart';
import 'package:womensafetyandsecurity/provider/guardianProvider.dart';

class addGuardian extends StatefulWidget {
  const addGuardian({super.key});

  @override
  State<addGuardian> createState() => _addGuardianState();
}

class _addGuardianState extends State<addGuardian> {
  final TextEditingController _guadian1 = TextEditingController();
  final TextEditingController _guadian2 = TextEditingController();
  final TextEditingController _email = TextEditingController();

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
                TextFormField(
                  controller: _guadian1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Guardian 1"),
                ),
                TextFormField(
                  controller: _guadian2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Guardian 2"),
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    final String id = "1";
                    final String guardian1 = _guadian1.text;
                    final String guardian2 = _guadian2.text;
                    final String email = _email.text;
                    if (guardian1.isEmpty || guardian1.length != 10) {
                      var snackbar = SnackBar(
                          content:
                              Text('Enter Correct Guardian 1 Phone Number!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else if (guardian2.isEmpty || guardian2.length != 10) {
                      var snackbar = SnackBar(
                          content:
                              Text('Enter Correct Guardian 2 Phone Number!!!'));
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
                      guadianProvider provider =
                          Provider.of(context, listen: false);

                      provider.addGuardianData(
                          id: id,
                          guardian1: guardian1,
                          guardian2: guardian2,
                          guardianEmail: email);
                      var snackbar = SnackBar(
                          content: Text('Guardian Data Added Successfully...'));
                      _guadian1.text = '';
                      _guadian2.text = '';
                      _email.text = '';
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

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    //provider = Provider.of<guadianProvider>(context);
    //var s = provider.getGuardianData();

    if (documentSnapshot != null) {
      //provider = Provider.of<guadianProvider>(context);
      //provider.getGuardianData();
      //guardianModel data = provider.getGuardianDataList as guardianModel;

      _guadian1.text = documentSnapshot['guardian1'];
      _guadian2.text = documentSnapshot['guardian2'];
      _email.text = documentSnapshot['guardianEmail'];
      //_guadian1.text = data.guardian1;
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
                TextFormField(
                  controller: _guadian1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Guardian 1"),
                ),
                TextFormField(
                  controller: _guadian2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(labelText: "Guardian 2"),
                ),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () {
                    final String id = "1";
                    final String guardian1 = _guadian1.text;
                    final String guardian2 = _guadian2.text;
                    final String email = _email.text;
                    if (_guadian1 != null &&
                        _guadian2 != null &&
                        _email != null) {
                      guadianProvider provider =
                          Provider.of(context, listen: false);

                      provider.updateGuardian(
                          id: id,
                          guardian1: guardian1,
                          guardian2: guardian2,
                          guardianEmail: email);
                      _guadian1.text = '';
                      _guadian2.text = '';
                      _email.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  final CollectionReference _addGuardian =
      FirebaseFirestore.instance.collection('addGuardian');

  late User user;
  //User? currentFirebaseUser = FirebaseAuth.instance.currentUser;
  Future<void> getData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    var email = FirebaseAuth.instance.currentUser!.email;
    if (currentUser != null) {
      setState(() {
        user = email as User;
        //print("ffdfdf" + currentUser.uid);
        print("ffdfdf" + email!);
      });
    }
  }

  // Future<void> _getUserName() async {
  //   FirebaseFirestore.instance
  //       .collection('addGuardian')
  //       .doc((await FirebaseAuth.instance.currentUser)!.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       var _username;
  //       _username = value.data['guardian1'].toString();
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getData();
  }

  late guadianProvider provider;
  showAlertDialog(BuildContext context, guardianModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        provider.guardianDelete(delete.id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Guardian Details"),
      content: Text("Are you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<guadianProvider>(context);
    provider.getGuardianData();
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Guardian"),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          itemCount: provider.getGuardianDataList.length,
          itemBuilder: (context, index) {
            guardianModel data = provider.getGuardianDataList[index];
            //print(data.guardian1);
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
                          "Guardian 1: " + data.guardian1,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0, top: 6),
                        child: Text(
                          "Guardian 2: " + data.guardian2,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0.0, top: 6),
                        child: Text(
                          "Guardian Email: " + data.guardianEmail,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        child: Row(children: [
                          IconButton(
                            onPressed: () => showAlertDialog(context, data),
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () => _update(),
                            icon: const Icon(Icons.edit),
                          ),
                        ]),
                      )
                    ]),
                  ),
                )
              ],
            );
          },
          // stream: _addGuardian.snapshots(),
          // builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          //   if (streamSnapshot.hasData) {
          //     return ListView.builder(
          //       itemCount: streamSnapshot.data!.docs.length,
          //       itemBuilder: (context, index) {
          //         //var email = FirebaseAuth.instance.currentUser!.email;

          //         final DocumentSnapshot documentSnapshot =
          //             streamSnapshot.data!.docs[index];
          //         return Card(
          //             margin: const EdgeInsets.all(12),
          //             child: Container(
          //               margin: const EdgeInsets.all(14),

          //               // child: ListTile(
          //               //   title: Text(
          //               //     documentSnapshot['policeID'],
          //               //   ),
          //               child: Column(children: [
          //                 Padding(
          //                   padding:
          //
          //   const EdgeInsets.only(right: 160.0, top: 10),
          //                   child: Text(
          //                     "Guardian 1: " +
          //                         documentSnapshot['guardian1'].toString(),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.only(right: 167.0, top: 10),
          //                   child: Text("Guardian 2: " +
          //                       documentSnapshot['guardian2'].toString()),
          //                 ),
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.only(right: 147.0, top: 10),
          //                   child: Text("Email: " +
          //                       documentSnapshot['guardianEmail']),
          //                 ),
          //                 SizedBox(
          //                   width: 100,
          //                   child: Row(
          //                     children: [
          //                       // IconButton(
          //                       //   icon: const Icon(Icons.edit),
          //                       //   onPressed: () => _update(documentSnapshot),
          //                       // ),
          //                       // IconButton(
          //                       //     icon: const Icon(Icons.delete),
          //                       //     onPressed: () =>
          //                       //         _delete(documentSnapshot.id)),
          //                     ],
          //                   ),
          //                 ),
          //               ]),
          //             ));
          //       },
          //     );
          //   }
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          //}
        ),
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

// class SingleProd extends StatelessWidget {
//   //const SingleProd({super.key});

//   String id;
//   String guardian1;
//   String guardian2;
//   String guardianEmail;

//   SingleProd(
//       {required this.id,
//       required this.guardian1,
//       required this.guardian2,
//       required this.guardianEmail});

//   @override
//   Widget build(BuildContext context) {
//     guadianProvider provider = Provider.of<guadianProvider>(context);
//     provider.getGuardianData();

//     return Scaffold(
//         backgroundColor: Colors.blueGrey,
//         appBar: AppBar(
//           title: Text("Guardian"),
//           backgroundColor: Colors.green,
//         ),
//         body: provider.getGuardianDataList.isEmpty?Center(child: Text("NO DATA"),):
//          ListView.builder(
//           itemCount: provider.getGuardianDataList.length,
//           itemBuilder: (context, index) {
//             guardianModel data = provider.getGuardianDataList[index];
//             return Column(
//               children: [
//                 SizedBox(height: 10,),
//                 SingleProd(id: data.id, guardian1: data.guardian1, guardian2: data.guardian2, guardianEmail: data.guardianEmail)
//               ],
//             );
//           },
//         ));
//   }
// }
