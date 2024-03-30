import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.orange[100],
      body: Column(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
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
                    "${widget.data["userData"]["username"]}'s fan",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(fanClients.length, (index) {
                      final client = fanClients[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.all(10),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Name: ${client["client"]}',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            CupertinoSwitch(
                              activeColor: Colors.green,
                              trackColor: Colors.redAccent,
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
                                    thumbColor: Colors.orange,
                                    activeColor: Colors.orange[700],
                                    inactiveColor: Colors.orange[200],
                                    value: sliderValues[index].toDouble(),
                                    min: 0,
                                    max: 2,
                                    divisions: 2,
                                    onChanged: (value) {
                                      setState(() {
                                        sliderValues[index] = value.toInt();
                                        _sendDataToServer(switchStates[index],
                                            client["client"]);
                                      });
                                    },
                                  )
                                : Container(),
                            SizedBox(height: 1),
                            Text(
                              switchStates[index]
                                  ? 'Speed : ${sliderValues[index] + 1}'
                                  : 'Fan is status Off',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[700]),
                            ),
                            SizedBox(height: 10),
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
