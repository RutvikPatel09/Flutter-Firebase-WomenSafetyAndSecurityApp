import 'package:flutter/material.dart';
import 'package:womensafetyandsecurity/main.dart';

class SplashScreen extends StatefulWidget {
  int duration = 0;
  Widget gotoPage;

  SplashScreen({required this.gotoPage, required this.duration});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.widget.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.widget.gotoPage));
    });

    return Scaffold(
        body: Container(
      color: Color(0xFF80C038),
      alignment: Alignment.center,
      child: IconFont(
        color: Colors.white,
        iconName: 'a',
        size: 100,
      ),
    ));
  }
}
