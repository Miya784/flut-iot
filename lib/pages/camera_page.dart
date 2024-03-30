import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_application_1/controller/controller.dart';

class CameraPage extends StatefulWidget {
  final dynamic data;

  CameraPage({Key? key, required this.data}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<VlcPlayerController> _vlcViewControllers;
  late List<dynamic> cameraClients;

  @override
  void initState() {
    super.initState();
    _setupVlcControllers();
  }

  void _setupVlcControllers() {
    cameraClients = widget.data['userData']['client']
        .where((client) => client['typeClient'] == 'Camera')
        .toList();

    _vlcViewControllers = cameraClients.map((client) {
      String url = "rtsp://mediamtx.wonyus.tech:9554/${client['client']}";
      return Controller.networkController(url, autoPlay: true);
    }).toList();
  }

  @override
  void dispose() {
    _vlcViewControllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
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
                      "${widget.data["userData"]["username"]}'s cam",
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var i = 0; i < _vlcViewControllers.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            'Cam name : ${cameraClients[i]['client']}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange[900],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          VlcPlayer(
                            controller: _vlcViewControllers[i],
                            aspectRatio: 16 / 9,
                            placeholder:
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
