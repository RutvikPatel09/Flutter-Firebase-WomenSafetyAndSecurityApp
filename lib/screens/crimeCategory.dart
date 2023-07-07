import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:womensafetyandsecurity/Search/search.dart';

class crimeCategory extends StatefulWidget {
  const crimeCategory({super.key});

  @override
  State<crimeCategory> createState() => _crimeCategoryState();
}

class _crimeCategoryState extends State<crimeCategory> {
  final TextEditingController _CrimeCategory = TextEditingController();

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
                  controller: _CrimeCategory,
                  decoration: const InputDecoration(labelText: 'Name'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _CrimeCategory.text;

                    if (name.isEmpty) {
                      var snackbar =
                          SnackBar(content: Text('Enter Crime Category!!!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    } else {
                      await _crimeCategory.add({"categoryName": name});
                      _CrimeCategory.text = '';
                      var snackbar =
                          SnackBar(content: Text('Crime Category Added!!!'));
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
    if (documentSnapshot != null) {
      _CrimeCategory.text = documentSnapshot['categoryName'];
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
                  controller: _CrimeCategory,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _CrimeCategory.text;
                    if (_CrimeCategory != null) {
                      await _crimeCategory
                          .doc(documentSnapshot!.id)
                          .update({"categoryName": name});
                      _CrimeCategory.text = '';
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
    await _crimeCategory.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Category')));
  }

  final CollectionReference _crimeCategory =
      FirebaseFirestore.instance.collection('crimeCategory');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Crime Category"),
          backgroundColor: Colors.green,
          actions: <Widget>[
            new IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => search()));
                },
                highlightColor: Colors.green,
                icon: new Icon(Icons.search))
          ],
        ),
        body: StreamBuilder(
            stream: _crimeCategory.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(14),
                      child: ListTile(
                        title: Text(documentSnapshot['categoryName']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => showDialog(
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
                                      })
                                      )
                            ],
                          ),
                        ),
                      ),
                    );
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
