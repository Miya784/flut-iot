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

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
    _initializeCoolModes();
    _initializeSwingLefts();
    _initializeSwingUps();
  }

  void _initializeSwitchStates() {
    airConditionClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Aircondition")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(airConditionClients.length, (index) => false);
    sliderValues = List.generate(airConditionClients.length,
        (index) => 22.0); // Default slider value as double
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Condition Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'User ID: ${widget.data["userData"]["userId"]}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Username: ${widget.data["userData"]["username"]}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Aircondition Clients:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(airConditionClients.length, (index) {
                  final client = airConditionClients[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Client ${index + 1}:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ID: ${client["client"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            switchStates[index] =
                                !switchStates[index]; // Toggle switch state
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
                        child: Text(switchStates[index]
                            ? 'ON'
                            : 'OFF'), // Display ON/OFF based on switch state
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isCoolModes[index] = !isCoolModes[index];
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
                                child:
                                    Text(isCoolModes[index] ? 'cool' : 'heat'),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isSwingLefts[index] = !isSwingLefts[index];
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
                                    child: Text(isSwingLefts[index]
                                        ? 'swing LR'
                                        : 'StopswingLR'),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isSwingUps[index] = !isSwingUps[index];
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
                                    child: Text(isSwingUps[index]
                                        ? 'swing UD'
                                        : 'stopswingUD'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
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
