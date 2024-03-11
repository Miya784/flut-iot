import 'package:flutter/material.dart';
import 'light_page.dart';
import 'fan_page.dart';
import 'air_condition_page.dart';
import 'camera_page.dart';
import 'add_device_page.dart';
import 'gate_page.dart'; // Import the GatePage

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    final String username = widget.data["userData"]['username'];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
        centerTitle: true, // Center the title
      ),
      body: GridView.count(
        crossAxisCount: 2, // 2 columns
        mainAxisSpacing: 10.0, // Vertical spacing between items
        crossAxisSpacing: 10.0, // Horizontal spacing between items
        padding: EdgeInsets.all(10.0),
        children: [
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LightPage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Light Page',
            description: 'Control lights',
          ),
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FanPage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Fan Page',
            description: 'Adjust fan settings',
          ),
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AirConditionPage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Air Condition Page',
            description: 'Set air conditioning',
          ),
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Camera Page',
            description: 'View cameras',
          ),
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDevicePage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Add Device Page',
            description: 'Add new devices',
          ),
          buildSquareButton(
            onPressed: () async {
              // Show loading state
              setState(() {
                _loading = true;
              });

              // Delay for 500ms
              await Future.delayed(Duration(milliseconds: 500));

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GatePage(data: widget.data),
                ),
              );

              // Hide loading state
              setState(() {
                _loading = false;
              });
            },
            label: 'Gate Page',
            description: 'Control gate',
          ),
        ],
      ),
    );
  }

  Widget buildSquareButton({
    required VoidCallback onPressed,
    required String label,
    required String description,
  }) {
    return ElevatedButton(
      onPressed: _loading ? null : onPressed, // Disable button when loading
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Make button square
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
