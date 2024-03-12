import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDevicePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const AddDevicePage({Key? key, required this.data}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  TextEditingController deviceNameController = TextEditingController();
  String? selectedDeviceType; // Store the selected device type

  Future<void> _addDevice() async {
    String userId = widget.data['userData']['userId']
        .toString(); // Convert userId to string
    String deviceType = selectedDeviceType ??
        ""; // Use selectedDeviceType if not null, otherwise use an empty string
    String deviceName = deviceNameController.text.isEmpty
        ? "stream1"
        : deviceNameController
            .text; // Use "stream1" as default device name if field is empty

    // Prepare the JSON payload
    Map<String, dynamic> requestBody = {
      'userId': userId,
      'newtypeClient': deviceType,
      'newclient': deviceName,
    };

    // Convert the map to JSON
    String jsonBody = jsonEncode(requestBody);

    // Example API request
    final response = await http.post(
      Uri.parse('https://node-emqx.burhan.cloud/client/addclient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.data["token"],
      },
      body: jsonBody,
    );

    // Handle response here, you can show a message or navigate back based on response
    if (response.statusCode == 200) {
      // Success, do something
      print('Device added successfully!');
    } else {
      // Failure, handle error
      print('Failed to add device. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: deviceNameController,
              decoration: InputDecoration(labelText: 'Device Name'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedDeviceType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDeviceType = newValue;
                });
              },
              items: <String>['Light', 'Fan', 'Aircondition', 'camera', 'Gate']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Device Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addDevice,
              child: Text('Add Device'),
            ),
          ],
        ),
      ),
    );
  }
}
