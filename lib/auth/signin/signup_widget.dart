import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/auth/UserDataProvider.dart';
import 'package:womensafetyandsecurity/auth/signin/theme.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';
import 'package:womensafetyandsecurity/screens/home_screen/home_screen.dart';

//Widget for input

class SignUpWidget extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusName = FocusNode();
  final FocusNode focusPhone = FocusNode();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
      ),
    ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 110.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          width: 360.00,
                          height: 480.00,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  focusNode: focusName,
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z]"))
                                  ],
                                  style: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.user,
                                        color: Colors.green,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter name",
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
                                    bottom: 20.0,
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
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  focusNode: focusPassword,
                                  controller: passwordController,
                                  obscureText: true,
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  focusNode: focusPhone,
                                  controller: phoneController,
                                  style: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.green,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter phone",
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
                                margin: EdgeInsets.only(top: 40.0),
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
                                      "Sign Up",
                                      style: TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          color: Colors.white,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    // final String name = nameController.text;
                                    // final String email = emailController.text;
                                    // final String password = passwordController.text;
                                    // final String phone = phoneController.text;
                                    // if (name != null) {
                                    //   UserDataProvider provider =
                                    //       Provider.of(context, listen: false);

                                    //   provider.addUserData(
                                    //       userEmail: email,
                                    //       userName: name,
                                    //       userPassword: password,
                                    //       userPhone: phone);
                                    //   Navigator.of(context).pop();
                                    // }
                                    String name = nameController.text;
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    String phone = phoneController.text;
                                    if (name.isEmpty) {
                                      showSnack('Please Enter Name!!!');
                                    } else if (email.isEmpty ||
                                        !RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                                            .hasMatch(email)) {
                                      showSnack(
                                          'Please Enter Correct Email!!!');
                                    } else if (password.isEmpty) {
                                      showSnack('Please Enter Password!!!');
                                    } else if (phone.isEmpty || phone.length != 10) {
                                      showSnack('Please Enter Correct Phone!!!');
                                    } else {
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen())).onError(
                                              (error, stackTrace) => {
                                                    print(
                                                        "Error ${error.toString()}")
                                                  }));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 16.0,
                                fontFamily: "WorkSansMedium"),
                          ),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: TextButton(
                      child: Text(
                        "Sign up with",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: "SignikaRegular"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
                              FontAwesomeIcons.github,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
                              FontAwesomeIcons.google,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))));
  }
}
