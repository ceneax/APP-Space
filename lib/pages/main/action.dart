import 'package:fish_redux/fish_redux.dart';

enum MainAction { tabChanged, changeNoticeNum, receivedBroadcast }

class MainActionCreator {

  static Action onTabChanged(int index) {
    return Action(MainAction.tabChanged, payload: index);
  }

  static Action onChangeNoticeNum(int num) {
    return Action(MainAction.changeNoticeNum, payload: num);
  }

  static Action onReceivedBroadcast(int num) {
    return Action(MainAction.receivedBroadcast, payload: num);
  }

}