import 'package:flutter/material.dart';

class AirConditionPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const AirConditionPage({Key? key, required this.data}) : super(key: key);

  @override
  _AirConditionPageState createState() => _AirConditionPageState();
}

class _AirConditionPageState extends State<AirConditionPage> {
  bool _isAirConditionerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Condition Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Air Conditioner'),
                Switch(
                  value: _isAirConditionerOn,
                  onChanged: (value) {
                    setState(() {
                      _isAirConditionerOn = value;
                    });
                    // Add your logic for toggling the air conditioner here
                  },
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
