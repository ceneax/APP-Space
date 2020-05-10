import 'package:fish_redux/fish_redux.dart';

class VastState implements Cloneable<VastState> {

  @override
  VastState clone() {
    return VastState();
  }
}

VastState initState(Map<String, dynamic> args) {
  return VastState();
}
