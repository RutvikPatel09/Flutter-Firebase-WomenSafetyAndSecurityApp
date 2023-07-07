import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:womensafetyandsecurity/Home/helper/admin_drawer.dart';
import 'package:womensafetyandsecurity/screens/Police/addPolice.dart';
import 'package:womensafetyandsecurity/screens/crimeCategory.dart';
import 'package:womensafetyandsecurity/screens/home_screen/allComplaints.dart';
import 'package:womensafetyandsecurity/widgets/categorycard.dart';
import '../Home/category.dart';
import '../Home/helper/my_drawer_header.dart';
import '../Home/utils.dart';
import '../auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/signin/login_widget.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  List<Category> categories = Utils.getMockedCategories();
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }

  var currentPage = DrawerSections.dashboard;

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [adminDrawer(), MyDrawerList()],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFF80C038),
            title: Text(
              'Welcome Admin',
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

          //CategorySelectionService catSelection = Provider.of<CategorySelectionService>(context, listen: false);
          //CategoryService catService = Provider.of<CategoryService>(context, listen: false);
          //List<Category> categories = catService.getCategories();
          // body: Container(
          //     child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: categories.length,
          //           itemBuilder: (BuildContext ctx, int index) {
          //             return CategoryCard(
          //                 category: categories[index],
          //                 onCardClick: () {
          //                   // catSelection.selectedCategory = categories[index];
          //                   // Utils.mainAppNav.currentState!.pushNamed('/selectedcategorypage');
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => crimeCategory()));
          //                 });
          //           },
          //         ),
          //       )
          //     ]))
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              buildImageCard(),
              buildImageCard1(),
              buildImageCard2(),
            ],
          ),
        ));
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
                  "https://blog.ipleaders.in/wp-content/uploads/2021/05/Medical_Consequence_of_Sexual_Harassment.jpg"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => crimeCategory()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 148.0),
            //   child: Text(
            //     'Crime Category',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget buildImageCard1() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK8EYJtKtOw1_4Y5QSrwOONC7ZxJp2J4m7C1DXMzc-wOFukJgmhEINDFKB4wvjukbNt9Q&usqp=CAU"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addPolice()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 155.0),
            //   child: Text(
            //     'Reports',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget buildImageCard2() => Card(
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
                      MaterialPageRoute(builder: (context) => allComplaints()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 155.0),
            //   child: Text(
            //     'All Complaints',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
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
