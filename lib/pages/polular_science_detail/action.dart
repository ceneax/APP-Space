import 'package:fish_redux/fish_redux.dart';

enum PolularScienceDetailAction { close, setData }

class PolularScienceDetailActionCreator {

  static Action onClose() {
    return Action(PolularScienceDetailAction.close);
  }

  static Action onSetData(var data) {
    return Action(PolularScienceDetailAction.setData, payload: data);
  }

}
