import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VastAction { action }

class VastActionCreator {
  static Action onAction() {
    return const Action(VastAction.action);
  }
}
