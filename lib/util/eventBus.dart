import 'package:event_bus/event_bus.dart';
import 'package:video_player/video_player.dart';

EventBus eventBus = new EventBus(sync: true);

class VideoPlayerEvent {
  static List<VideoPlayerController> controllers = new List();
  VideoPlayerController controller;
  VideoPlayerEvent({this.controller}) : super() {
    try {
      controllers.add(this.controller);
    } catch (err) {
      print(err);
    }
  }

  // void call(VideoPlayerController controller) {
  //   controllers.add(controller);
  // }
}

class PlayStop {
  Function playStop;
  PlayStop(this.playStop);
}
