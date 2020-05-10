import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscuzPage extends Page<DiscuzState, Map<String, dynamic>> {
  DiscuzPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DiscuzState>(
                adapter: null,
                slots: <String, Dependent<DiscuzState>>{
                }),
            middleware: <Middleware<DiscuzState>>[
            ],);

}
