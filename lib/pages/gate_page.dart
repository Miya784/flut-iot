import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api-Publist_service.dart';

class GatePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const GatePage({Key? key, required this.data}) : super(key: key);

  @override
  _GatePageState createState() => _GatePageState();
}

class _GatePageState extends State<GatePage> {
  late List<Map<String, dynamic>> GateClients;
  late List<bool> switchStates;

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
  }

  void _initializeSwitchStates() {
    GateClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Gate")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(GateClients.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gate Page'),
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
                'Gate Clients:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(GateClients.length, (index) {
                  final client = GateClients[index];
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
                              ? 'on'
                              : 'off'; // Determine switch data based on its state
                          _sendDataToServer(switchData, client["client"]);
                        },
                        child: Text(switchStates[index]
                            ? 'ON'
                            : 'OFF'), // Display ON/OFF based on switch state
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

  Future<void> _sendDataToServer(String switchData, String client) async {
    try {
      // ignore: unused_local_variable
      final response = await apiPublist_service.sendDataToServer(
        switchData: switchData,
        token: widget.data["token"],
        clientIndex: client,
      );
      // if (response.statusCode == 500) {
      //   print('Data sent successfully!');
      //   _updateSwitchState(client);
      // } else {
      //   print('Failed to send data. Status code: ${response.statusCode}');
      // }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _updateSwitchState(String clientId) {
    final index =
        GateClients.indexWhere((client) => client["client"] == clientId);
    if (index != -1) {
      setState(() {
        switchStates[index] = !switchStates[index];
      });
    }
  }
}
