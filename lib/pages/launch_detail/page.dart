import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LaunchDetailPage extends Page<LaunchDetailState, Map<String, dynamic>> {
  LaunchDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LaunchDetailState>(
                adapter: null,
                slots: <String, Dependent<LaunchDetailState>>{
                }),
            middleware: <Middleware<LaunchDetailState>>[
            ],);

}
