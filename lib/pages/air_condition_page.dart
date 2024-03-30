import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api-Publist_service.dart';

class AirConditionPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const AirConditionPage({Key? key, required this.data}) : super(key: key);

  @override
  _AirConditionPageState createState() => _AirConditionPageState();
}

class _AirConditionPageState extends State<AirConditionPage> {
  late List<Map<String, dynamic>> airConditionClients;
  late List<bool> switchStates;
  late List<double> sliderValues; // Changed to double
  late List<bool> isCoolModes;
  late List<bool> isSwingLefts;
  late List<bool> isSwingUps;
  late List<bool> isIncrease;
  late List<bool> isDecrease;

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
    _initializeCoolModes();
    _initializeSwingLefts();
    _initializeSwingUps();
    _initializeDecrease();
    _initializeIncrease();
  }

  void _initializeSwitchStates() {
    airConditionClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Aircondition")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(airConditionClients.length, (index) => false);
    sliderValues = List.generate(airConditionClients.length, (index) => 22.0);
  }

  void _initializeCoolModes() {
    isCoolModes = List.generate(airConditionClients.length, (index) => true);
  }

  void _initializeSwingLefts() {
    isSwingLefts = List.generate(airConditionClients.length, (index) => true);
  }

  void _initializeSwingUps() {
    isSwingUps = List.generate(airConditionClients.length, (index) => true);
  }

  void _initializeIncrease() {
    isIncrease = List.generate(airConditionClients.length, (index) => true);
  }

  void _initializeDecrease() {
    isDecrease = List.generate(airConditionClients.length, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 25, right: 10),
              decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // This line ensures navigation back to the home page
                        },
                        icon: Icon(
                          Icons.home,
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                    Text(
                      "${widget.data["userData"]["username"]}'s AC",
                      style: TextStyle(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          List.generate(airConditionClients.length, (index) {
                        final client = airConditionClients[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: switchStates[index]
                                    ? Colors.green.withOpacity(0.7)
                                    : Colors.grey.withOpacity(0.7),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${client["client"]}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[700]),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(100, 40),
                                    foregroundColor: Colors.white,
                                    backgroundColor: switchStates[index]
                                        ? Colors.green
                                        : Colors.red,
                                    // Add other styles as needed
                                    shadowColor: switchStates[index]
                                        ? Colors.green
                                        : Colors.red,
                                    elevation: 10,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      switchStates[index] = !switchStates[
                                          index]; // Toggle switch state
                                    });
                                    String switchData = switchStates[index]
                                        ? 'ON'
                                        : 'OFF'; // Determine switch data based on its state
                                    _sendDataToServer(
                                      switchStates[index],
                                      client["client"],
                                      switchData,
                                      sliderValues[
                                          index], // Use slider value of the current client
                                    );
                                  },
                                  child: Icon(
                                    switchStates[index]
                                        ? (Icons.power_settings_new)
                                        : (Icons.power_settings_new),
                                  ), // Display ON/OFF based on switch state
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 40),
                                      foregroundColor: Colors.white,
                                      backgroundColor: isCoolModes[index]
                                          ? Colors.white
                                          : Colors.redAccent,
                                      // Add other styles as needed
                                      shadowColor: isCoolModes[index]
                                          ? Colors.blue
                                          : Colors.redAccent,
                                      elevation: 10,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isCoolModes[index] =
                                            !isCoolModes[index];
                                        sliderValues[index] = isCoolModes[index]
                                            ? 22.0
                                            : 28.0; // Assign the slider value of the current client
                                        _sendDataToServer(
                                          switchStates[index],
                                          client["client"],
                                          isCoolModes[index] ? "cool" : "heat",
                                          sliderValues[
                                              index], // Use slider value of the current client
                                        );
                                      });
                                    },
                                    child: SizedBox(
                                        width: 80,
                                        height: 50,
                                        child: Center(
                                          child: Icon(
                                            isCoolModes[index]
                                                ? CupertinoIcons
                                                    .thermometer_snowflake
                                                : CupertinoIcons
                                                    .thermometer_sun,
                                            color: isCoolModes[index]
                                                ? Colors.blue
                                                : Colors.white,
                                          ),
                                        )),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Text(
                                        'Swing',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[700]),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor:
                                                  isSwingLefts[index]
                                                      ? Colors.orange[700]
                                                      : Colors.orange[700],
                                              backgroundColor:
                                                  isSwingLefts[index]
                                                      ? Colors.white
                                                      : Colors.white,
                                              // Add other styles as needed
                                              shadowColor: isSwingLefts[index]
                                                  ? Colors.orange[700]
                                                  : Colors.grey,
                                              elevation: 10,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isSwingLefts[index] =
                                                    !isSwingLefts[index];
                                                _sendDataToServer(
                                                  switchStates[index],
                                                  client["client"],
                                                  isSwingLefts[index]
                                                      ? "swingLR"
                                                      : "StopswingLR",
                                                  sliderValues[
                                                      index], // Use slider value of the current client
                                                );
                                              });
                                            },
                                            child: SizedBox(
                                              width: 110,
                                              height: 50,
                                              child: Center(
                                                child: Icon(CupertinoIcons
                                                    .arrow_left_right),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor:
                                                  Colors.orange[700],

                                              backgroundColor: Colors.white,

                                              // Add other styles as needed
                                              shadowColor: isSwingUps[index]
                                                  ? Colors.orange[700]
                                                  : Colors.grey,
                                              elevation: 10,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isSwingUps[index] =
                                                    !isSwingUps[index];
                                                _sendDataToServer(
                                                  switchStates[index],
                                                  client["client"],
                                                  isSwingUps[index]
                                                      ? "swingUD"
                                                      : "stopswingUD",
                                                  sliderValues[
                                                      index], // Use slider value of the current client
                                                );
                                              });
                                            },
                                            child: SizedBox(
                                              width: 110,
                                              height: 50,
                                              child: Center(
                                                child: Icon(CupertinoIcons
                                                    .arrow_up_arrow_down),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Text(
                                        'Temperature',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[700]),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.white,
                                              shadowColor: Colors.red,
                                              elevation: 10,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isIncrease[index] =
                                                    !isIncrease[index];
                                                _sendDataToServer(
                                                  switchStates[index],
                                                  client["client"],
                                                  isIncrease[index]
                                                      ? "Increase"
                                                      : "Increase",
                                                  sliderValues[
                                                      index], // Use slider value of the current client
                                                );
                                              });
                                            },
                                            child: SizedBox(
                                              width: 110,
                                              height: 50,
                                              child: Center(
                                                  child: Icon(CupertinoIcons
                                                      .plus_rectangle)),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.blue,
                                              backgroundColor: Colors.white,
                                              shadowColor: Colors.blue,
                                              elevation: 10,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isDecrease[index] =
                                                    !isDecrease[index];
                                                _sendDataToServer(
                                                  switchStates[index],
                                                  client["client"],
                                                  isDecrease[index]
                                                      ? "Decrease"
                                                      : "Decrease",
                                                  sliderValues[index],
                                                );
                                              });
                                            },
                                            child: SizedBox(
                                              width: 110,
                                              height: 50,
                                              child: Center(
                                                child: Icon(CupertinoIcons
                                                    .minus_rectangle),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendDataToServer(
    bool switchData,
    String client,
    String command,
    double sliderValue,
  ) async {
    try {
      final index =
          airConditionClients.indexWhere((item) => item["client"] == client);
      if (index != -1) {
        String fullCommand;
        switch (command) {
          case "slider":
            fullCommand = "$command$sliderValue";
            break;
          case "ON":
          case "cool":
          case "heat":
          case "swingLR":
          case "swingUD":
          case "StopswingLR":
          case "stopswingUD":
            fullCommand = command;
            break;
          default:
            fullCommand = "OFF";
            break;
        }
        // ignore: unused_local_variable
        final response = await apiPublist_service.sendDataToServer(
          switchData: switchData ? fullCommand : "OFF",
          token: widget.data["token"],
          clientIndex: client,
        );
        // if (response.statusCode == 500) {
        //   print('Data sent successfully!');
        //   _updateSwitchState(index);
        // } else {
        //   print('Failed to send data. Status code: ${response.statusCode}');
        // }
      } else {
        print('Failed to find client with ID: $client');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _updateSwitchState(int index) {
    if (index != -1) {
      setState(() {
        switchStates[index] = !switchStates[index];
      });
    }
  }
}
