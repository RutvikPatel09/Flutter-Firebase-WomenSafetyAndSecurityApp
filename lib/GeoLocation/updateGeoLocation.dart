import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class updateGeoLocation extends StatefulWidget {
  String lat, long;
  updateGeoLocation({super.key, required this.lat, required this.long});

  @override
  State<updateGeoLocation> createState() => _updateGeoLocationState();
}

class _updateGeoLocationState extends State<updateGeoLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF80C038),
        title: Text(
          'Update Geo Location',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 288.0),
                child: Text(
                  'Lat: ${widget.lat}',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Long: ${widget.long}',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
