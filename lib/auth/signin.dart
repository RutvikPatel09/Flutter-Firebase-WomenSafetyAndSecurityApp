import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:womensafetyandsecurity/auth/login.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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

      return user;
    } catch (e) {
      //print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              height: 400,
              width: double.infinity,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Sign in to Continue"),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Women App',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.green,
                          shadows: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.green,
                                offset: Offset(3, 3))
                          ]),
                    )),
                Column(
                  children: [
                    SignInButton(
                      Buttons.Apple,
                      text: "Sign in with Apple",
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () {
                        googleSignUp();
                        //.then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home())))
                      },
                    ), 
                  //  SizedBox(
                  //   height: 12,
                  //   ),
                  //   Text("Admin Login",
                  //   style: TextStyle(color: Colors.lightBlue),),
                  //   SizedBox(
                  //     height: 18,
                  //   ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {   Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Login()));   },
                   child: Text( "Admin Login...",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                   color: Colors.blue), ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          'By Signing in you are agreeing to our',
                          style: TextStyle(color: Colors.grey[800]),
                        )),
                    Text('Terms and Privacy Policy',
                        style: TextStyle(color: Colors.grey[800])),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
