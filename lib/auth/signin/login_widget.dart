import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/auth/ForgotPassword.dart';
import 'package:womensafetyandsecurity/auth/signin/signup_widget.dart';
import 'package:womensafetyandsecurity/auth/signin/theme.dart';
import 'package:womensafetyandsecurity/policeLogin/policeLogin.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';

import '../../screens/adminHome.dart';

//Widget for input

class LoginWidget extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _mainScaffoldKey =
      new GlobalKey<ScaffoldState>();

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

  late UserProvider userProvider;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User?> googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
          currentuser: user,
          userName: user!.displayName,
          userEmail: user.email,
          userImage: user.photoURL);

      return user;
    } catch (e) {
      //print(e.message);
    }
  }

  static Future<User?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for this email");
      }
    }
    return user;
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.black54,
                key: _mainScaffoldKey,
                body: Container(
                  padding: EdgeInsets.only(top: 110.0),
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
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 24.0, bottom: 26.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
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
                                            begin: const FractionalOffset(
                                                0.2, 0.2),
                                            end: const FractionalOffset(
                                                1.0, 1.0),
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
                                        User? user = await login(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context);
                                        print(user);
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        if (email.isEmpty ||
                                            !RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                                                .hasMatch(email)) {
                                          showSnack(
                                              'Please Enter Correct Phone!!!');
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        } else if (password.isEmpty) {
                                          showSnack('Please Enter Password!!!');
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        } else {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      adminHome()));
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      child: Text(
                                        "Police Login",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontFamily: "SignikaRegular"),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    policeLogin()));
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
                        child: TextButton(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: "SignikaRegular"),
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword())),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.white],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(0.5, 0.5),
                                stops: [0.1, 0.5],
                                tileMode: TileMode.clamp)),
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  color: Colors.black,
                                  fontSize: 22.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpWidget()));
                          },
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, right: 40.0),
                            child: GestureDetector(
                              onTap: () {},
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
                              onTap: () {},
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
                              onTap: () {},
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
                              onTap: () => googleSignUp(),
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
