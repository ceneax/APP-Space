import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VideoPlayerState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoPlayerState>>{
      VideoPlayerAction.setVideoSize: _setVideoSize,
      VideoPlayerAction.setSocket: _setSocket,
      VideoPlayerAction.updateOnlineNum: _updateOnlineNum,
    },
  );
}

VideoPlayerState _setVideoSize(VideoPlayerState state, Action action) {
  return state.clone()
    ..videoWidth = action.payload['width']
    ..videoHeight = action.payload['height'];
}

VideoPlayerState _setSocket(VideoPlayerState state, Action action) {
  return state.clone()
    ..socket = action.payload;
}

VideoPlayerState _updateOnlineNum(VideoPlayerState state, Action action) {
  return state.clone()
    ..onlineNum = action.payload;
}