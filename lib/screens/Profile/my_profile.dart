import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';

// ignore: must_be_immutable
class MyProfile extends StatefulWidget {
  //const MyProfile({super.key});
  UserProvider userProvider;
  MyProfile({required this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    var userData = userProvider.currentUserData;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              //padding: const EdgeInsets.only(left: 100.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 70,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userData.userImage),
                  radius: 40,
                ),
              ),
            ),
            Center(
              //padding: const EdgeInsets.only(left: 88.0),
              child: Text(
                userData.userName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Center(
              //padding: const EdgeInsets.only(left: 88.0),
              child: Text(
                userData.userEmail,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Update'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
