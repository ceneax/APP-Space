import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<LaunchHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<LaunchHeaderState>>{
//    LaunchHeaderAction.onHeaderClick: _onHeaderClick,
  });
}

//void _onHeaderClick(Action action, Context<LaunchHeaderState> ctx) {
//}