import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FakeCall extends StatefulWidget {
  const FakeCall({super.key});

  @override
  State<FakeCall> createState() => _FakeCallState();
}

class _FakeCallState extends State<FakeCall> {
  //late AudioPlayer audioPlayer;
  //AudioCache cache = AudioCache();
  //static AudioCache _player = new AudioCache();
  Color _backgroundColor = Color(0xFF163345);
  Random random = Random();
  String _caller = "";
  String areaCode = "310";
  String prefix = "";
  String lastFour = "";
  List callerList = [
    "Rutvik",
    "Rutvik",
    "Rutvik",
    "Rutvik",
    "Rutvik",
    "Rutvik",
    "Rutvik",
    "Rutvik",
  ];

  bool ringing = false;
  bool startScreen = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void _start() {
    int callerIndex = random.nextInt(callerList.length);
    int pre = random.nextInt(899) + 100;
    int lf = random.nextInt(8999) + 1000;
    setState(() {
      prefix = pre.toString();
      lastFour = lf.toString();
      _caller = callerList[callerIndex];
      startScreen = false;
    });
    _ring();
  }

  AudioPlayer player = AudioPlayer();
  void _ring() async {
    ringing = true;
    do {
      // audioPlayer = await cache.play("");
      //await player.play(AssetSource("assets/audio/iphone6.mp3"));
      String audioasset = "assets/audio/iphone6.mp3";
      ByteData bytes = await rootBundle.load(audioasset);
      Uint8List soundbytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      await player.playBytes(soundbytes);
      await Future.delayed(Duration(seconds: 10));
    } while (ringing);
  }

  void stopRing() {
    player.stop();
    ringing = false;
  }

  void reset() {
    player.stop();
    ringing = false;
    setState(() {
      startScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: startScreen ? Colors.black : _backgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                _caller,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              Text(
                "$areaCode-$prefix-$lastFour",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        "Remind Me",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text("Message", style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: stopRing,
                        onDoubleTap: reset,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {},
                          child: Icon(
                            Icons.call_end,
                            size: 34,
                          ),
                        ),
                      ),
                      Text("Decline", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          onPressed: () {},
                          child: Icon(
                            Icons.phone,
                            size: 34,
                          ),
                        ),
                      ),
                      Text("Accept", style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          if (startScreen)
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.black,
                    )),
                Expanded(
                    flex: 0,
                    child: GestureDetector(
                      onLongPress: _start,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.grey[900],
                      ),
                    ))
              ],
            )
        ],
      ),
    );
  }
}
