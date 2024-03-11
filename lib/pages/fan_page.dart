import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api-Publist_service.dart';

class FanPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const FanPage({Key? key, required this.data}) : super(key: key);

  @override
  _FanPageState createState() => _FanPageState();
}

class _FanPageState extends State<FanPage> {
  late List<Map<String, dynamic>> fanClients;
  late List<bool> switchStates;
  late List<int> sliderValues;

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
  }

  void _initializeSwitchStates() {
    fanClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Fan")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(fanClients.length, (index) => false);
    sliderValues = List.generate(fanClients.length, (index) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fan Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                'Fan Clients:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(fanClients.length, (index) {
                  final client = fanClients[index];
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
                            _sendDataToServer(value, client["client"]);
                          });
                        },
                      ),
                      SizedBox(height: 1),
                      switchStates[index]
                          ? Slider(
                              value: sliderValues[index].toDouble(),
                              min: 0,
                              max: 2,
                              divisions: 2,
                              onChanged: (value) {
                                setState(() {
                                  sliderValues[index] = value.toInt();
                                  _sendDataToServer(
                                      switchStates[index], client["client"]);
                                });
                              },
                            )
                          : Container(),
                      SizedBox(height: 1),
                      Text(
                        switchStates[index]
                            ? 'Fan Level: ${sliderValues[index] + 1}'
                            : 'Fan is status Off',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
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

  Future<void> _sendDataToServer(bool switchData, String client) async {
    try {
      final index =
          fanClients.indexWhere((fanClient) => fanClient["client"] == client);
      if (index != -1) {
        final response = await apiPublist_service.sendDataToServer(
          switchData: switchData ? "ON${sliderValues[index] + 1}" : "Off",
          token: widget.data["token"],
          clientIndex: client,
        );
        if (response.statusCode == 500) {
          print('Data sent successfully!');
          _updateSwitchState(client);
        } else {
          print('Failed to send data. Status code: ${response.statusCode}');
        }
      } else {
        print('Failed to find fan client with ID: $client');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _updateSwitchState(String clientId) {
    final index =
        fanClients.indexWhere((client) => client["client"] == clientId);
    if (index != -1) {
      setState(() {
        switchStates[index] = !switchStates[index];
      });
    }
  }
}
