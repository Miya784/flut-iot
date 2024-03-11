import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api-Publist_service.dart';

class AirConditionPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const AirConditionPage({Key? key, required this.data}) : super(key: key);

  @override
  _AirConditionPageState createState() => _AirConditionPageState();
}

class _AirConditionPageState extends State<AirConditionPage> {
  // bool _switchValue = false;
  double _sliderValue = 22;
  bool _isCoolMode = true;
  bool _isSwingLeft = true;
  bool _isSwingUp = true;
  late List<Map<String, dynamic>> airConditionClients;
  late List<bool> switchStates;
  late List<int> sliderValues;

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
  }

  void _initializeSwitchStates() {
    airConditionClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Aircondition")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(airConditionClients.length, (index) => false);
    sliderValues = List.generate(
        airConditionClients.length, (index) => 22); // Default slider value
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
                      Switch(
                        value: switchStates[index],
                        onChanged: (value) {
                          setState(() {
                            switchStates[index] = value;
                            _sendDataToServer(
                              value,
                              client["client"],
                              value ? "ON" : "OFF",
                              _sliderValue,
                            );
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      if (switchStates[
                          index]) // Show sliders and buttons only if the switch is on
                        Column(
                          children: [
                            // Slider(
                            //   value: sliderValues[index].toDouble(),
                            //   min: 22,
                            //   max: 28,
                            //   divisions: 6,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _sliderValue = value;
                            //       sliderValues[index] = value.toInt();
                            //       _sendDataToServer(
                            //         switchStates[index],
                            //         client["client"],
                            //         "slider",
                            //         value,
                            //       );
                            //     });
                            //   },
                            // ),
                            SizedBox(height: 10),
                            // Text('Temperature: $_sliderValue°C'),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isCoolMode = !_isCoolMode;
                                  _sliderValue = _isCoolMode ? 22 : 28;
                                  _sendDataToServer(
                                    switchStates[index],
                                    client["client"],
                                    _isCoolMode ? "cool" : "heat",
                                    _sliderValue,
                                  );
                                });
                              },
                              child: SizedBox(
                                width: 80,
                                height: 50,
                                child: Center(
                                  child: Text(_isCoolMode ? 'cool' : 'heat'),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isSwingLeft = !_isSwingLeft;
                                      _sendDataToServer(
                                        switchStates[index],
                                        client["client"],
                                        _isSwingLeft
                                            ? "swingLR"
                                            : "StopswingLR",
                                        _sliderValue,
                                      );
                                    });
                                  },
                                  child: SizedBox(
                                    width: 110,
                                    height: 50,
                                    child: Center(
                                      child: Text(_isSwingLeft
                                          ? 'swing LR'
                                          : 'StopswingLR'),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isSwingUp = !_isSwingUp;
                                      _sendDataToServer(
                                        switchStates[index],
                                        client["client"],
                                        _isSwingUp ? "swingUD" : "stopswingUD",
                                        _sliderValue,
                                      );
                                    });
                                  },
                                  child: SizedBox(
                                    width: 110,
                                    height: 50,
                                    child: Center(
                                      child: Text(_isSwingUp
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
        final response = await apiPublist_service.sendDataToServer(
          switchData: switchData ? fullCommand : "OFF",
          token: widget.data["token"],
          clientIndex: client,
        );
        if (response.statusCode == 500) {
          print('Data sent successfully!');
          _updateSwitchState(index);
        } else {
          print('Failed to send data. Status code: ${response.statusCode}');
        }
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
