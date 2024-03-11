import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package

class GatePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const GatePage({Key? key, required this.data}) : super(key: key);

  @override
  _GatePageState createState() => _GatePageState();
}

class _GatePageState extends State<GatePage> {
  bool _isLoading = false;

  Future<void> _sendGateAction(String action) async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    // Define your API URL
    String apiUrl = 'https://your-api-url.com/gate';

    // Define your JSON body
    Map<String, dynamic> requestBody = {
      'action': action,
      // You can add any additional parameters needed by your API
    };

    try {
      // Send the HTTP POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Add any additional headers needed by your API
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Request successful
        print('Gate $action successful');
      } else {
        // Request failed
        print('Failed to $action gate: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred while sending request
      print('Error sending $action request: $e');
    } finally {
      // Hide loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gate Page'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _sendGateAction('open'); // Send open gate request
                    },
                    child: Text('Open Gate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _sendGateAction('close'); // Send close gate request
                    },
                    child: Text('Close Gate'),
                  ),
                ],
              ),
            ),
    );
  }
}
