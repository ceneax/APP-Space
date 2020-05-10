import 'package:fish_redux/fish_redux.dart';

import 'package:space/pages/me/components/me_notice_dialog/component.dart';
import 'package:space/pages/me/components/me_notice_dialog/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MePage extends Page<MeState, Map<String, dynamic>> {
  MePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MeState>(
                adapter: null,
                slots: <String, Dependent<MeState>>{
                  'notice_dialog': MeNoticeDialogConnector() + MeNoticeDialogComponent(),
                }),
            middleware: <Middleware<MeState>>[
            ],);

}
