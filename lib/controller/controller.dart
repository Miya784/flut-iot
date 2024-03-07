import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class Controller {
  static VlcPlayerController networkController(String url,
      {bool autoPlay = false}) {
    return VlcPlayerController.network(
      url,
      autoPlay: autoPlay,
    );
  }
}
