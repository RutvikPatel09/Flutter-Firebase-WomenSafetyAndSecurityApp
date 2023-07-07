import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womensafetyandsecurity/auth/signin/theme.dart';
import 'package:womensafetyandsecurity/policeDashboard/policeHome.dart';

class policeLogin extends StatefulWidget {
  const policeLogin({super.key});

  @override
  State<policeLogin> createState() => _policeLoginState();
}

class _policeLoginState extends State<policeLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _mainScaffoldKey =
      new GlobalKey<ScaffoldState>();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("addPolice");

  // Future<void> getDocs() async {
  //   QuerySnapshot querySnapshot = await collectionReference.get();

  //   final Email = querySnapshot.docs.map((doc) => doc['Email']).toList();
  //   final Password = querySnapshot.docs.map((doc) => doc['policeID']).toList();
  //   //print(Email + Password);

  //   if (emailController.text == Email && passwordController.text == Password) {
  //     print("Success");
  //     // Navigator.of(context).pushReplacement(
  //     //                                     MaterialPageRoute(
  //     //                                         builder: (context) =>
  //     //                                             adminHome()));
  //   }
  //   //return Email + Password;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black54,
        key: _mainScaffoldKey,
        body: Container(
          padding: EdgeInsets.only(top: 200.0),
          child: Column(
            children: <Widget>[
              Stack(
                //overflow: TextOverflow.ellipsis,
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      width: 360.00,
                      height: 370.00,
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.flutter_dash_outlined,
                              color: Colors.green,
                              size: 60,
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 5.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: focusEmail,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.green,
                                    size: 22.0,
                                  ),
                                  hintText: "Enter email",
                                  hintStyle: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 18.0)),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 5.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: focusPassword,
                              obscureText: true,
                              controller: passwordController,
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.green,
                                    size: 22.0,
                                  ),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 18.0)),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 60.0, bottom: 26.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.greenAccent,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0),
                                  BoxShadow(
                                      color: Colors.green,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0),
                                ],
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.green,
                                      Colors.lightGreenAccent
                                    ],
                                    begin: const FractionalOffset(0.2, 0.2),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.1, 1.0],
                                    tileMode: TileMode.clamp)),
                            child: MaterialButton(
                              highlightColor: Colors.transparent,
                              splashColor: AppColours.colorEnd,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 42.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      color: Colors.white,
                                      fontSize: 22.0),
                                ),
                              ),
                              onPressed: () async {
                                QuerySnapshot querySnapshot =
                                    await collectionReference.get();

                                final Email = querySnapshot.docs
                                    .map((doc) => doc['Email'])
                                    .toList();
                                final Password = querySnapshot.docs
                                    .map((doc) => doc['policeID'])
                                    .toList();
                                var EmailString = Email.join();
                                var PasswordString = Password.join();
                                //print(StringList);
                                if (EmailString == emailController.text &&
                                    PasswordString == passwordController.text) {
                                  // print("Success");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => policeHome()));
                                } else {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }

                                  var snackbar = SnackBar(
                                      content: Text('Data not found!!!'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(0.5, 0.5),
                        stops: [0.1, 0.5],
                        tileMode: TileMode.clamp)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white10,
                              Colors.white,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white10,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
