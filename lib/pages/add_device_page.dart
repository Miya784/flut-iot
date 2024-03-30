import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Capitalize only the first letter
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text[0].toUpperCase() + newValue.text.substring(1),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}

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
      // Show a snackbar notification for success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Device added successfully! Please click the Refresh button'),
        ),
      );
      // Success, do something
      print('Device added successfully!');
    } else {
      // Failure, handle error
      print('Failed to add device. Status code: ${response.statusCode}');
    }
  }

  void _restartApp() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/', // The initial route of your app
      (route) => false, // Remove all routes except the initial route
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(''),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                child: Text(
                  'Add a device',
                  style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepOrangeAccent),
              ),
              child: TextField(
                controller: deviceNameController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Device name'),
                cursorColor: Colors.orange,
                inputFormatters: [
                  UpperCaseTextFormatter(), // Restrict input to capitalize the first letter
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 200, // Adjust the width of the dropdown button
              child: DropdownButtonFormField<String>(
                value: selectedDeviceType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDeviceType = newValue;
                  });
                },
                items: <String>[
                  'Light',
                  'Fan',
                  'Aircondition',
                  'Camera',
                  'Gate'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16), // Adjust the font size
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  hintText: 'Select a device',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.deepOrangeAccent), // Customize border color
                    borderRadius:
                        BorderRadius.circular(10), // Customize border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .deepOrange), // Customize focused border color
                    borderRadius: BorderRadius.circular(
                        10), // Customize focused border radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: _addDevice,
                child: Text('Add Device'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange[700],
                  elevation:
                      10, // Adjust the value to control the shadow intensity
                  shadowColor: Colors
                      .grey, // You can customize the shadow color if needed
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: _restartApp,
                child: Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange[700],
                  elevation:
                      10, // Adjust the value to control the shadow intensity
                  shadowColor: Colors
                      .grey, // You can customize the shadow color if needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
