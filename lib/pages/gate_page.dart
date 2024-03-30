import 'package:flutter/cupertino.dart';
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
                    "${widget.data["userData"]["username"]}'s gate",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(GateClients.length, (index) {
                      final client = GateClients[index];
                      return Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200, // Set a fixed width here
                                child: Text(
                                  'NAME  ${client["client"]}',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700]),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                width: 250,
                              ),
                              SizedBox(
                                  width:
                                      20), // Add spacing between text and button
                              SizedBox(
                                width: 100, // Set a fixed width for the button
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        // Add other styles as needed
                                        shadowColor: Colors.green,
                                        elevation: 10,
                                      ),
                                      onPressed: () {
                                        String switchData = 'Open';
                                        _sendDataToServer(
                                            switchData, client["client"]);
                                      },
                                      child: Text(
                                        'Open',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[50],
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        // Add other styles as needed
                                        shadowColor: Colors.green,
                                        elevation: 10,
                                      ),
                                      onPressed: () {
                                        String switchData = 'Close';
                                        _sendDataToServer(
                                            switchData, client["client"]);
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[50],
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ],
                          ),
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
        GateClients.indexWhere((client) => client["client"] == clientId);
    if (index != -1) {
      setState(() {
        switchStates[index] = !switchStates[index];
      });
    }
  }
}
