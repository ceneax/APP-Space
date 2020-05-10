import 'package:fish_redux/fish_redux.dart';

enum LaunchDetailAction { inited, closePage, showVideo }

class LaunchDetailActionCreator {

  static Action onInited(double data) {
    return Action(LaunchDetailAction.inited, payload: data);
  }

  static Action onClosePage() {
    return Action(LaunchDetailAction.closePage);
  }

  static Action onShowVideo() {
    return Action(LaunchDetailAction.showVideo);
  }

}
