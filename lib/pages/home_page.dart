import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 17)),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 300,
                        child: Text(
                          "Welcome home ,",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Text(
                          username,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.orange[700],
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              height: 140),
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 15,
            padding: EdgeInsets.all(40),
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
                        builder: (context) => AddDevicePage(data: widget.data),
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
              buildSquareButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  label: "Logout",
                  icon: Icon(
                    Icons.logout,
                    size: 100,
                  ))
            ],
          ))
        ],
      ),
    );
  }

  Widget buildSquareButton({
    required VoidCallback onPressed,
    required String label,
    required Icon icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
