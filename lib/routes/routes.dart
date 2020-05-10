import 'package:fish_redux/fish_redux.dart';

import 'package:space/global_store/state.dart';
import 'package:space/global_store/store.dart';
import 'package:space/pages/discuz/page.dart';
import 'package:space/pages/launch/page.dart';
import 'package:space/pages/launch_detail/page.dart';
import 'package:space/pages/littleCosmos/page.dart';
import 'package:space/pages/login/page.dart';
import 'package:space/pages/look/page.dart';
import 'package:space/pages/main/page.dart';
import 'package:space/pages/me/page.dart';
import 'package:space/pages/new_post/page.dart';
import 'package:space/pages/polular_science/page.dart';
import 'package:space/pages/polular_science_detail/page.dart';
import 'package:space/pages/post_detail/page.dart';
import 'package:space/pages/register/page.dart';
import 'package:space/pages/vast/page.dart';
import 'package:space/pages/video_player/page.dart';

class Routes {
  static final PageRoutes routes = PageRoutes(
      pages: <String, Page<Object, dynamic>> { /// 在这里注册页面
        'main_page': MainPage(),
        'launch_page': LaunchPage(),
        'launch_detail_page': LaunchDetailPage(),
        'little_cosmos_page': LittleCosmosPage(),
        'discuz_page': DiscuzPage(),
        'new_post_page': NewPostPage(),
        'me_page': MePage(),
        'login_page': LoginPage(),
        'register_page': RegisterPage(),
        'post_detail_page': PostDetailPage(),
        'look_page': LookPage(),
        'video_palyer_page': VideoPlayerPage(),
        'polular_science_page': PolularSciencePage(),
        'polular_science_detail_page': PolularScienceDetailPage(),
        'vast_page': VastPage(),
      },
      visitor: (String path, Page<Object, dynamic> page) {
        /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
        /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
        if(page.isTypeof<GlobalBaseState>()) {
          /// 建立 AppStore 驱动 PageStore 的单向数据连接
          /// 1. 参数1 AppStore
          /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
          page.connectExtraStore<GlobalState>(GlobalStore.store, (Object pageState, GlobalState appState) {
            final GlobalBaseState p = pageState;

            /// globalState中有属性变化的话，也要在这里改动
            if(p.themeData != appState.themeData || p.isLogin != appState.isLogin || p.userInfo != appState.userInfo) {
              if(pageState is Cloneable) {
                final Object copy = pageState.clone();
                final GlobalBaseState newState = copy;

                newState.themeData = appState.themeData;
                newState.userInfo = appState.userInfo;
                newState.isLogin = appState.isLogin;

                return newState;
              }
            }

            return pageState;
          });
        }

        /// AOP
        /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
        /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
//        page.enhancer.append(
//          /// View AOP
//          viewMiddleware: <ViewMiddleware<dynamic>>[
//            safetyView<dynamic>(),
//          ],
//
//          /// Adapter AOP
//          adapterMiddleware: <AdapterMiddleware<dynamic>>[
//            safetyAdapter<dynamic>()
//          ],
//
//          /// Effect AOP
//          effectMiddleware: <EffectMiddleware<dynamic>>[
//            _pageAnalyticsMiddleware<dynamic>(),
//          ],
//
//          /// Store AOP
//          middleware: <Middleware<dynamic>>[
//            logMiddleware<dynamic>(tag: page.runtimeType.toString()),
//          ],
//        );
      }
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
//EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
//  return (AbstractLogic<dynamic> logic, Store<T> store) {
//    return (Effect<dynamic> effect) {
//      return (Action action, Context<dynamic> ctx) {
//        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
//          print('${logic.runtimeType} ${action.type.toString()} ');
//        }
//        return effect?.call(action, ctx);
//      };
//    };
//  };
//}