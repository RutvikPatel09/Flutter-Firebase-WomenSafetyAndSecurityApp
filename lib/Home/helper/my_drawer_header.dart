import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';

// ignore: must_be_immutable
class MyHeaderDrawer extends StatefulWidget {
  //const MyHeaderDrawer({super.key});
  UserProvider userProvider;
  MyHeaderDrawer({required this.userProvider});
  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 70,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userData.userImage),
              radius: 40,
            ),
          ),
          Text(
            userData.userName,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            userData.userEmail,
            style: TextStyle(color: Colors.grey[200], fontSize: 14),
          )
        ],
      ),
    );
  }
}
