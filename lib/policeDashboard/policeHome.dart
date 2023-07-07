import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensafetyandsecurity/Complaints/complaints.dart';
import 'package:womensafetyandsecurity/Home/helper/police_drawer.dart';
import 'package:womensafetyandsecurity/auth/signin/login_widget.dart';

class policeHome extends StatefulWidget {
  const policeHome({super.key});

  @override
  State<policeHome> createState() => _policeHomeState();
}

class _policeHomeState extends State<policeHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }

  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [policedrawer(), MyDrawerList()],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF80C038),
        title: Text(
          'Welcome Officer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFF80C038),
            child: Icon(Icons.search, size: 17, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () {
                signOut();
              },
              child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFF80C038),
                  child: Icon(Icons.logout, size: 17, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [buildImageCard()],
      ),
    );
  }

  Widget buildImageCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                  "https://www.superoffice.com/globalassets/blog/2013/5/customer-complaints.jpg"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Complaints()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 170.0),
            //   child: Text(
            //     'Complaints',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w900,
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.contacts_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.notes;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { dashboard, contacts, notes }
