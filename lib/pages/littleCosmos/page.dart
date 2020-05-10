import 'package:fish_redux/fish_redux.dart';

import 'package:space/pages/littleCosmos/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LittleCosmosPage extends Page<LittleCosmosState, Map<String, dynamic>> {

  LittleCosmosPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LittleCosmosState>(
                adapter: null,
                slots: <String, Dependent<LittleCosmosState>>{
                }),
            middleware: <Middleware<LittleCosmosState>>[
            ],);

  /// 给tabController用
  @override
  ComponentState<LittleCosmosState> createState() {
    return LittleCosmosComponentState();
  }

}
