import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/models/UserModel.dart';
import 'package:womensafetyandsecurity/provider/feedbackProvider.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';

class FeedbackData extends StatefulWidget {
  const FeedbackData({super.key});

  @override
  State<FeedbackData> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackData> {
  final TextEditingController FeedbackDesc = TextEditingController();
  final TextEditingController Name = TextEditingController();

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
                  controller: FeedbackDesc,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(labelText: "Feedback"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    // UserProvider userProvider = Provider.of(context, listen: false);
                    // userProvider.getUserData();
                    // UserModel data = userProvider.getUserDataList as UserModel;
                    // final String name = data.userName;
                    final String FeedbackDescData = FeedbackDesc.text;
                    DateTime currentDate = DateTime.now();
                    Timestamp myTimeStamp = Timestamp.fromDate(currentDate);
                    DateTime myDateTime = myTimeStamp.toDate();
                    print(myDateTime);
                    if (FeedbackDescData.isEmpty) {
                      var snackbar = SnackBar(
                          content: Text('Enter Feedback to Submit!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else {
                      feedbackProvider provider =
                          Provider.of(context, listen: false);
                      // UserProvider userProvider = Provider.of(context);

                      provider.addFeedbackData(
                          FeedbackDesc: FeedbackDescData,
                          Timestamp: myDateTime.toString());

                      var snackbar = SnackBar(
                          content: Text('Feedback Send Successfully...'));
                      FeedbackDesc.text = '';
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

  late feedbackProvider provider;
  @override
  Widget build(BuildContext context) {
    //provider = Provider.of<feedbackProvider>(context);
    //provider.getGuardianData();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Feedback"),
          backgroundColor: Colors.green,
        ),
        // body: ListView.builder(
        //   itemCount: provider.getGuardianDataList.length,
        //   itemBuilder: (context, index) {
        //     guardianModel data = provider.getGuardianDataList[index];
        //     //print(data.guardian1);
        //     return Column(
        //       children: [
        //         SizedBox(height: 20),
        //         Card(
        //           margin: const EdgeInsets.all(12),
        //           child: Container(
        //             margin: const EdgeInsets.all(14),
        //             child: Column(children: [
        //               Padding(
        //                 padding: const EdgeInsets.only(right: 68.0),
        //                 child: Text(
        //                   "Guardian 1: " + data.guardian1,
        //                   style: TextStyle(fontSize: 17),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.only(right: 30.0, top: 6),
        //                 child: Text(
        //                   "Guardian 2: " + data.guardian2,
        //                   style: TextStyle(fontSize: 17),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.only(right: 0.0, top: 6),
        //                 child: Text(
        //                   "Guardian Email: " + data.guardianEmail,
        //                   style: TextStyle(fontSize: 17),
        //                 ),
        //               ),
        //             ]),
        //           ),
        //         )
        //       ],
        //     );
        //   },
        // ),
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
