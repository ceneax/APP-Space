import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MeNoticeDialogState> buildReducer() {
  return asReducer(
    <Object, Reducer<MeNoticeDialogState>>{
      MeNoticeDialogAction.setNotice: _setNotice,
      MeNoticeDialogAction.loadMoreFinished: _loadMoreFinished,
      MeNoticeDialogAction.dispose: _dispose,
    },
  );
}

MeNoticeDialogState _setNotice(MeNoticeDialogState state, Action action) {
  return MeNoticeDialogState()
    ..updateType = MeNoticeDialogUpdateType.SET
    ..notice = action.payload;
}

MeNoticeDialogState _loadMoreFinished(MeNoticeDialogState state, Action action) {
  return MeNoticeDialogState()
    ..updateType = MeNoticeDialogUpdateType.ADD
    ..noticeCurrentPage = state.noticeCurrentPage + 1
    ..notice = action.payload;
}

MeNoticeDialogState _dispose(MeNoticeDialogState state, Action action) {
  return MeNoticeDialogState()
    ..updateType = MeNoticeDialogUpdateType.CLEAN;
}