import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api-Publist_service.dart';

class LightPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const LightPage({Key? key, required this.data}) : super(key: key);

  @override
  _LightPageState createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  late List<Map<String, dynamic>> lightClients;
  late List<bool> switchStates;

  @override
  void initState() {
    super.initState();
    _initializeSwitchStates();
  }

  void _initializeSwitchStates() {
    lightClients = widget.data["userData"]["client"]
        .where((client) => client["typeClient"] == "Light")
        .cast<Map<String, dynamic>>()
        .toList();
    switchStates = List.generate(lightClients.length, (index) => false);
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "${widget.data["userData"]["username"]} 's Light",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.orange[900],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(lightClients.length, (index) {
                  final client = lightClients[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Name : ${client["client"]}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        CupertinoSwitch(
                          trackColor: Colors.orange[100],
                          activeColor: Colors.orange,
                          thumbColor: Colors.white,
                          value: switchStates[index],
                          onChanged: (newValue) {
                            setState(() {
                              switchStates[index] = newValue;
                            });
                            String switchData = newValue ? 'on' : 'off';
                            _sendDataToServer(switchData, client["client"]);
                          },
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
    );
  }

  Future<void> _sendDataToServer(String switchData, String client) async {
    try {
      final response = await apiPublist_service.sendDataToServer(
        switchData: switchData,
        token: widget.data["token"],
        clientIndex: client,
      );
      if (response.statusCode == 500) {
        print('Data sent successfully!');
        _updateSwitchState(client);
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _updateSwitchState(String clientId) {
    final index =
        lightClients.indexWhere((client) => client["client"] == clientId);
    if (index != -1) {
      setState(() {
        switchStates[index] = !switchStates[index];
      });
    }
  }
}
