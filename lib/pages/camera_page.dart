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
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < _vlcViewControllers.length; i++)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    VlcPlayer(
                      controller: _vlcViewControllers[i],
                      aspectRatio: 16 / 9,
                      placeholder: Center(child: CircularProgressIndicator()),
                    ),
                    Text('Camera Clients: ${cameraClients[i]['client']}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
