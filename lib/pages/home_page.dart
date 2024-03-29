import 'package:flutter/material.dart';
import 'pages/light_page.dart';
import 'pages/fan_page.dart';
import 'pages/air_condition_page.dart';
import 'pages/camera_page.dart';
import 'pages/add_device_page.dart';
import 'pages/gate_page.dart'; // Import the GatePage

class HomePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final String username = widget.data["userData"]['username'];

    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
                child: Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                    Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Welcome home ,",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.orange[700],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(60))),
                height: 150),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(50),
              children: [
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

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
                    label: "Light",
                    icon: Icon(
                      Icons.lightbulb_outline,
                      size: 100,
                    )),
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

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
                    label: "Fan",
                    icon: Icon(
                      Icons.air_outlined,
                      size: 100,
                    )),
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

                      // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AirConditionPage(data: widget.data),
                        ),
                      );

                      // Hide loading state
                      setState(() {
                        _loading = false;
                      });
                    },
                    label: "Aircondition",
                    icon: Icon(
                      Icons.ac_unit_outlined,
                      size: 100,
                    )),
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

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
                    label: "Camera",
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 100,
                    )),
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

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
                    label: "Gate",
                    icon: Icon(
                      Icons.door_sliding_outlined,
                      size: 100,
                    )),
                buildSquareButton(
                    onPressed: () async {
                      // Show loading state
                      setState(() {
                        _loading = true;
                      });

                      // Delay for 3 seconds (simulating a connection check)
                      await Future.delayed(Duration(seconds: 3));

                      // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddDevicePage(data: widget.data),
                        ),
                      );

                      // Hide loading state
                      setState(() {
                        _loading = false;
                      });
                    },
                    label: "Add device",
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 100,
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget buildSquareButton({
    required VoidCallback onPressed,
    required String label,
    required Icon icon,
  }) {
    return ElevatedButton(
      onPressed: _loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[50],
        foregroundColor: Colors.orange[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          // Make button square
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            label,
            style: TextStyle(fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
