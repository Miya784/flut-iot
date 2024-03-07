import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/air_condition_page.dart';
import 'package:flutter_application_1/pages/camera_page.dart';
import 'package:flutter_application_1/pages/fan_page.dart';
import 'light_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LightPage(data: widget.data),
                  ),
                );
              },
              child: Text('Light Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FanPage(data: widget.data),
                  ),
                );
              },
              child: Text('Fan Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AirConditionPage(data: widget.data),
                  ),
                );
              },
              child: Text('Air Condition Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraPage(data: widget.data)),
                );
              },
              child: Text('Camera Page'),
            ),
          ],
        ),
      ),
    );
  }
}
