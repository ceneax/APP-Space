import 'package:fish_redux/fish_redux.dart';

enum VideoType {
  LIVE,
  NORMAL,
  BILIBILI
}

enum VideoPlayerAction { willPop, setVideoSize, setSocket, sendMsg, updateOnlineNum }

class VideoPlayerActionCreator {

  static Action onWillPop() {
    return Action(VideoPlayerAction.willPop);
  }

  static Action onSetVideoSize(double width, double height) {
    return Action(VideoPlayerAction.setVideoSize, payload: {
      'width': width,
      'height': height
    });
  }

  static Action onSetSocket(var socket) {
    return Action(VideoPlayerAction.setSocket, payload: socket);
  }

  static Action onSendMsg() {
    return Action(VideoPlayerAction.sendMsg);
  }

  static Action onUpdateOnlineNum(int num) {
    return Action(VideoPlayerAction.updateOnlineNum, payload: num);
  }

}
