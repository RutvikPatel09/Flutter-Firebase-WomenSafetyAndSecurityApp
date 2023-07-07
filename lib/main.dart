import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:womensafetyandsecurity/Complaint/createComplaint.dart';
import 'package:womensafetyandsecurity/Complaints/complaints.dart';
import 'package:womensafetyandsecurity/DataFromAPI/LawsApi.dart';
import 'package:womensafetyandsecurity/Feedback/feedback.dart';
import 'package:womensafetyandsecurity/Search/search.dart';
import 'package:womensafetyandsecurity/auth/ForgotPassword.dart';
import 'package:womensafetyandsecurity/auth/UserDataProvider.dart';
import 'package:womensafetyandsecurity/auth/signin.dart';
import 'package:womensafetyandsecurity/auth/signin/signup_widget.dart';
import 'package:womensafetyandsecurity/policeDashboard/policeHome.dart';
import 'package:womensafetyandsecurity/policeLogin/policeLogin.dart';
import 'package:womensafetyandsecurity/provider/addPoliceProvider.dart';
import 'package:womensafetyandsecurity/provider/complaintProvider.dart';
import 'package:womensafetyandsecurity/provider/feedbackProvider.dart';
import 'package:womensafetyandsecurity/provider/guardianProvider.dart';
import 'package:womensafetyandsecurity/provider/userProvider.dart';
import 'package:womensafetyandsecurity/reports/generateReports.dart';
import 'package:womensafetyandsecurity/screens/Fake%20Call/fake_call.dart';
import 'package:womensafetyandsecurity/screens/Guardian/addGuardian.dart';
import 'package:womensafetyandsecurity/screens/LawScreen/laws.dart';
import 'package:womensafetyandsecurity/screens/Police/addPolice.dart';
import 'package:womensafetyandsecurity/screens/SafetyVideos/safetyVideos.dart';
import 'package:womensafetyandsecurity/screens/TipsandTricks/tipsandtricks.dart';
import 'package:womensafetyandsecurity/screens/adminHome.dart';
import 'package:womensafetyandsecurity/screens/crimeCategory.dart';
import 'package:womensafetyandsecurity/screens/home_screen/allComplaints.dart';
import 'package:womensafetyandsecurity/screens/home_screen/home_screen.dart';
import 'package:womensafetyandsecurity/screens/splashScreen.dart';
import 'package:womensafetyandsecurity/screens/verticalCard.dart';

import 'auth/signin/login_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class IconFont extends StatelessWidget {
  Color color;
  double size;
  String iconName;

  IconFont({required this.color, required this.size, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.iconName,
      style: TextStyle(
          color: this.color, fontSize: this.size, fontFamily: 'orilla'),
    );
  }
}

//ChangeNotifierProvider(create: (context)=>UserProvider()),
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => guadianProvider(),),
        ChangeNotifierProvider(create: (context)=>feedbackProvider(),),
        ChangeNotifierProvider(create: (context)=>complaintProvider(),),
        ChangeNotifierProvider(create: (context)=>UserDataProvider(),),
        ChangeNotifierProvider(create: (context)=>policeProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          // home: StreamBuilder(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return HomeScreen();
          //     }
          //     return SignIn();
          //   },
          // )
          home: SplashScreen(
              duration: 3,
              gotoPage: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomeScreen();
                  }
                  return LoginWidget();
                }, 
          ))
          //home: adminHome(),

          ),
    );
  }
}
