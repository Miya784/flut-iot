import 'package:flutter/material.dart';

class FanPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const FanPage({Key? key, required this.data}) : super(key: key);

  @override
  _FanPageState createState() => _FanPageState();
}

class _FanPageState extends State<FanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fan Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your logic for the first button here
              },
              child: Text('Button 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the second button here
              },
              child: Text('Button 2'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the third button here
              },
              child: Text('Button 3'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the fourth button here
              },
              child: Text('Button 4'),
            ),
          ],
        ),
      ),
    );
  }
}
