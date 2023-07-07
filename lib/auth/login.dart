import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:womensafetyandsecurity/screens/adminHome.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
        body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Women App",
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          "Login to Continue...",
          style: TextStyle(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 44),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "User Email",
            prefixIcon: Icon(
              Icons.mail,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 26),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "User Password",
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "Don't Remember your Password?",
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          padding: const EdgeInsets.all(32),
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: Color(0xff0069FE),
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () async {
              User? user = await login(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
              print(user);
              if (user != null) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => adminHome()));
              }
            },
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    ));
  }
}
