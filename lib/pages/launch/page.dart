import 'package:fish_redux/fish_redux.dart';

import 'package:space/pages/launch/components/header/component.dart';
import 'package:space/pages/launch/components/header/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LaunchPage extends Page<LaunchState, Map<String, dynamic>> {
  LaunchPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LaunchState>(
                adapter: null,
                slots: <String, Dependent<LaunchState>>{
                  'header': LaunchHeaderConnector() + LaunchHeaderComponent(),
                }),
            middleware: <Middleware<LaunchState>>[
            ],);

}
