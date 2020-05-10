import 'package:fish_redux/fish_redux.dart';

enum MeAction { headClick, changeVersionName, menuClick }

class MeActionCreator {

  static Action onHeadClick() {
    return Action(MeAction.headClick);
  }

  static Action onChangeVersionName(String data) {
    return Action(MeAction.changeVersionName, payload: data);
  }

  static Action onMenuClick(String data) {
    return Action(MeAction.menuClick, payload: data);
  }

}
