import 'package:flutter/material.dart';

class tipsandtricks extends StatelessWidget {
  const tipsandtricks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF80C038),
          title: Text(
            'Tips & Tricks',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tips & Tricks:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "1.  Be aware of your surroundings."
                    "Don’t let your guard down"
                    "a. If things seem even a slight unsafe get out of that place immediately",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "2. Don’t take eve teasing lightly"
                    "\n"
                    "\na. Respond with a stern voice"
                    "\nb. Threaten to take a picture which might scare them away"
                    "\nc. If the eve teasing still persists then immediately raise your voice to gather a crowd",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "3. As much as possible avoid late night travel using public transport"
                    "\n"
                    "\na. If avoiding is not possible then be sure to travel only on crowded bus"
                    "\nb. Avoid taking road side cabs"
                    "\nc. Avoid using a bus which has no passenger or few passenger",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "4. While using 2 wheeler be sure to wear helmet at all times (especially at night)."
                    "Don’t stop for any stranger"
                    "\na. In case attacked, use your helmet to defend yourself",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "5. While driving a car:"
                    "\n"
                    "\na. Avoid parking at desolate area"
                    "\nb. Look inside the car especially the back seat before unlocking & entering"
                    "\nc. Lock the doors immediately after entering the car"
                    "\nd. Start the car & drive off rather then call someone. Calls can wait"
                    "\ne. Don’t give lift to strangers"
                    "\nf. Don’t stop your car for strangers, especially at night"
                    "\ng. Take known routes, avoid short cuts which you don’t know",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "6. After getting dropped don’t stay outside to take a call"
                    "\na. Take calls on your phone only when you have entered your home & not outside",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
