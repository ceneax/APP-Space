import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<VastState> buildEffect() {
  return combineEffects(<Object, Effect<VastState>>{
    VastAction.action: _onAction,
  });
}

void _onAction(Action action, Context<VastState> ctx) {
}
