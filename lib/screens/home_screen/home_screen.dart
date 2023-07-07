import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womensafetyandsecurity/Complaint/createComplaint.dart';
import 'package:womensafetyandsecurity/DataFromAPI/LawsApi.dart';
import 'package:womensafetyandsecurity/Feedback/feedback.dart';
import 'package:womensafetyandsecurity/GeoLocation/updateGeoLocation.dart';
import 'package:womensafetyandsecurity/Home/category.dart';
import 'package:womensafetyandsecurity/Home/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';
import 'package:womensafetyandsecurity/screens/Fake%20Call/fake_call.dart';
import 'package:womensafetyandsecurity/screens/Guardian/addGuardian.dart';
import 'package:womensafetyandsecurity/screens/LawScreen/laws.dart';
import 'package:womensafetyandsecurity/screens/Profile/my_profile.dart';
import 'package:womensafetyandsecurity/screens/SafetyVideos/safetyVideos.dart';
import 'package:womensafetyandsecurity/screens/TipsandTricks/tipsandtricks.dart';
import 'package:womensafetyandsecurity/screens/home_screen/ComplaintsByClient.dart';
import '../../Home/helper/my_drawer_header.dart';
import '../../auth/signin/login_widget.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemark);
    Placemark place = placemark[0];

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("addGuardian");
    QuerySnapshot querySnapshot = await collectionReference
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourGuardian")
        .get();

    final guardian1 =
        querySnapshot.docs.map((data) => data['guardian1']).toList();
    print(guardian1);
    final guardian2 =
        querySnapshot.docs.map((data) => data['guardian2']).toList();
    var mobile1 = guardian1.join();
    var mobile2 = guardian2.join();

    Address =
        '${place.name}, ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}';
    launch(
        'sms:[+918511964810,+91$mobile1,+91$mobile2],?body=Hey, This is Testing SOS, ${Address}');
    setState(() {});
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginWidget()));
  }

  List<Category> categories = Utils.getMockedCategories();

  Future<bool> _onWillPop() async {
    return false;
  }

  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    MyHeaderDrawer(userProvider: userProvider),
                    MyDrawerList()
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.sos),
            backgroundColor: Colors.green,
            onPressed: () async {
              Position position = await _determinePosition();
              //print(position.latitude);
              //print(position.longitude);
              location = 'Lat: ${position.latitude},Long:${position.longitude}';
              GetAddressFromLatLong(position);
              //Future<void> finalLocation = GetAddressFromLatLong(position);
              setState(() {});
              //launch('sms:+916352440574?body=Hey, This is Testing SOS ${Address}');
            },
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFF80C038),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF80C038),
                child: Icon(Icons.search, size: 17, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: GestureDetector(
                  onTap: () async {
                    final urlPreview =
                        'https://play.google.com/store/apps/details?id=com.kalpicapp.mygtuapp&hl=en&gl=US';
                    await Share.share(
                        'You can download the app from below link..\n $urlPreview');
                  },
                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF80C038),
                      child: Icon(Icons.share, size: 17, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
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
            children: [
              buildImageCard(),
              buildImageCard1(),
              buildImageCard2(),
              buildImageCard3(),
              buildImageCard4()
            ],
          ),
          // body: Container(
          //   child:
          //       Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          //     Expanded(
          //       child: ListView.builder(
          //         itemCount: categories.length,
          //         itemBuilder: (BuildContext ctx, int index) {
          //           return Container(
          //             margin: EdgeInsets.all(20),
          //             height: 150,
          //             child: Stack(
          //               children: [
          //                 Positioned.fill(
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(20),
          //                     child: Image.asset(
          //                         'assets/img/' +
          //                             categories[index].imgName +
          //                             '.png',
          //                         fit: BoxFit.cover),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   bottom: 0,
          //                   right: 0,
          //                   left: 0,
          //                   child: Container(
          //                       height: 120,
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.only(
          //                               bottomLeft: Radius.circular(20),
          //                               bottomRight: Radius.circular(20)),
          //                           gradient: LinearGradient(
          //                               begin: Alignment.bottomCenter,
          //                               end: Alignment.topCenter,
          //                               colors: [
          //                                 Colors.black.withOpacity(0.7),
          //                                 Colors.transparent
          //                               ]))),
          //                 ),
          //                 Positioned(
          //                     bottom: 0,
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(10),
          //                       child: Row(
          //                         children: [
          //                           CategoryIcon(
          //                             color: categories[index].color,
          //                             iconName: categories[index].icon,
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Text(
          //                               categories[index].name,
          //                               style: TextStyle(
          //                                   color: Colors.white, fontSize: 25),
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ))
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ]),
          // ),
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
                  "https://thumbs.dreamstime.com/b/family-icon-parents-baby-logo-vector-illustration-happy-family-icon-parents-baby-logo-vector-illustration-169121437.jpg"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addGuardian()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 148.0),
            //   child: Text(
            //     'Guardian',
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
                  "https://img.freepik.com/premium-vector/we-want-your-feedback-text-colorful-bright-speech-bubble-background-feedback-opinion-concept_499817-280.jpg?w=2000"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackData()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Text(
                'Feedback',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
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
                  "https://economictimes.indiatimes.com/photo/68388575.cms"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => createComplaint()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 170.0),
            //   child: Text(
            //     'Create Complaint',
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

  Widget buildImageCard3() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                  "https://images.ctfassets.net/3prze68gbwl1/asset-17suaysk1qa1k0c/3152c26d548a58fe75cb53bf630961a7/Realtime-Google-Maps-Geolocation-Tracking-with-JavaScript.jpg"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () async {
                  Position position = await _determinePosition();
                  //print(position.latitude);
                  //print(position.longitude);
                  setState(() {});

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => updateGeoLocation(
                                lat: position.latitude.toString(),
                                long: position.longitude.toString(),
                              )));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

  Widget buildImageCard4() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                  "https://www.techadv.com/sites/default/files/styles/blog_header/public/2020-04/complaints.jpg.jpeg?itok=3DLBe1zX"),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComplaintsByClient()));
                },
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
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
          menuItem(2, "My Profile", Icons.verified_user,
              currentPage == DrawerSections.MyProfile ? true : false),
          menuItem(3, "Laws", Icons.list_alt_outlined,
              currentPage == DrawerSections.laws ? true : false),
          menuItem(4, "Tips and Tricks", Icons.tips_and_updates_outlined,
              currentPage == DrawerSections.tipsandtricks ? true : false),
          menuItem(5, "Safety Videos", Icons.safety_check_outlined,
              currentPage == DrawerSections.SafetyVideos ? true : false),
          menuItem(6, "Fake Call", Icons.phone,
              currentPage == DrawerSections.FakeCall ? true : false),
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
          //UserProvider userProvider = Provider.of(context);
          //  userProvider.getUserData();
          //userProvider.currentUserData;
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.MyProfile;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userProvider: UserProvider(),
                          )));
            } else if (id == 3) {
              currentPage = DrawerSections.laws;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LawsAPI()));
            } else if (id == 4) {
              currentPage = DrawerSections.tipsandtricks;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tipsandtricks()));
            } else if (id == 5) {
              currentPage = DrawerSections.SafetyVideos;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => safetyVideos(
                            title: "Safety Videos",
                          )));
            } else if (id == 6) {
              currentPage = DrawerSections.FakeCall;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FakeCall()));
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

enum DrawerSections {
  dashboard,
  MyProfile,
  laws,
  tipsandtricks,
  SafetyVideos,
  FakeCall
}
