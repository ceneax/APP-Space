import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VastPage extends Page<VastState, Map<String, dynamic>> {
  VastPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VastState>(
                adapter: null,
                slots: <String, Dependent<VastState>>{
                }),
            middleware: <Middleware<VastState>>[
            ],);

}
