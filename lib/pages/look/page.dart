import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LookPage extends Page<LookState, Map<String, dynamic>> {
  LookPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LookState>(
                adapter: null,
                slots: <String, Dependent<LookState>>{
                }),
            middleware: <Middleware<LookState>>[
            ],);

}
