import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VideoPlayerPage extends Page<VideoPlayerState, Map<String, dynamic>> {
  VideoPlayerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VideoPlayerState>(
                adapter: null,
                slots: <String, Dependent<VideoPlayerState>>{
                }),
            middleware: <Middleware<VideoPlayerState>>[
            ],);

}
