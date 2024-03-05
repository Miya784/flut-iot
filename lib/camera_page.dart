import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: Center(
        child: Text(
          'This is the Camera Page.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
