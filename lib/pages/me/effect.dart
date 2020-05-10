import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

import 'package:space/global_store/action.dart';
import 'package:space/global_store/store.dart';
import 'package:space/network/api.dart';
import 'package:space/network/api3.dart';
import 'package:space/pages/main/action.dart';
import 'package:space/theme.dart';
import 'package:space/utils/app_util.dart';
import 'package:space/utils/dialog_util.dart';

import 'action.dart';
import 'state.dart';

Effect<MeState> buildEffect() {
  return combineEffects(<Object, Effect<MeState>>{
    Lifecycle.initState: _init,
    MeAction.headClick: _headClick,
    MeAction.menuClick: _menuClick,
  });
}

void _init(Action action, Context<MeState> ctx) async {
  var versionInfo = await AppUtil.getAppVersionInfo();
  ctx.dispatch(MeActionCreator.onChangeVersionName(versionInfo['versionName']));
}

/// 修改头像
void _changeAvatar(Context<MeState> ctx) async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  if(image == null)
    return;

  image = await ImageCropper.cropImage(
    sourcePath: image.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square
    ],
    cropStyle: CropStyle.circle,
    androidUiSettings: AndroidUiSettings(
        toolbarColor: ctx.state.themeData.primaryColor,
        toolbarWidgetColor: Colors.white
    ),
  );
  if(image == null)
    return;

  DialogUtil.showLoading(ctx.context, content: '正在修改，稍等～');

  var res = await Api3.getInstance().uploadFile(image, '/avatar');
  if(res == false) {
    DialogUtil.close(ctx.context);
    showToast('图片上传失败啦！！');
    return;
  }

  /// 图片上传成功，修改服务端数据
  var res2 = await Api.getInstance().updateUserInfo(ctx.state.userInfo['sessionToken'], ctx.state.userInfo['objectId'], res);
  if(res2 is int) {
    DialogUtil.close(ctx.context);
    showToast('头像修改失败啦！！代码：$res2');
    /// 判断是否为209，是的话就是用户session过期，执行退出登录
    return;
  }
  
  var res3 = await Api.getInstance().retrieveUserInfo(ctx.state.userInfo['sessionToken']);
  if(res3 is int) {
    DialogUtil.close(ctx.context);
    showToast('头像修改成功~~但尝试获取最新数据失败！！');
    /// 判断是否为209，是的话就是用户session过期，执行退出登录
    return;
  }

  DialogUtil.close(ctx.context);
  showToast('头像修改成功！！');
  GlobalStore.store.dispatch(GlobalActionCreator.onLogin(res3));
}

void _headClick(Action action, Context<MeState> ctx) {
  if(ctx.state.isLogin) {
    DialogUtil.showGeneralList(ctx.context, ['修改头像'], (index) {
      if(index == 0) {
        _changeAvatar(ctx);
      }
    });
  } else {
    Navigator.pushNamed(ctx.context, 'login_page');
  }
}

/// 检查当前主题是否为暗黑，是的话就提示重启app
void _checkCurrentTheme(Context<MeState> ctx, var themeType, var themeStyle) {
  if(ctx.state.themeData.brightness == Brightness.dark) {
    DialogUtil.showMyDialog(ctx.context, '注意啦', '现在你的主题是暗黑（夜间），切换为其他主题需要重启APP才能生效哦~', okText: '修改并重启！', cancelText: '还是不了吧', okAction: () async {
      GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeData(themeType, themeStyle));
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  } else {
    GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeData(themeType, themeStyle));
  }
}

void _menuClick(Action action, Context<MeState> ctx) {
  switch(action.payload) {
    case '回复我的':
      ctx.broadcast(MainActionCreator.onReceivedBroadcast(0)); /// 通知mainPage将红点去掉
      showModalBottomSheet(
          context: ctx.context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20))
          ),
          builder: (context) => ctx.buildComponent('notice_dialog')
      );
      break;
    case '换个心情':
      DialogUtil.showGeneralList(ctx.context, ['默认蓝', '革命红', '原谅绿', '暗黑（夜间）'], (index) {
        switch(index) {
          case 0:
            _checkCurrentTheme(ctx, ThemeType.LIGHT_DEFAULT, ThemeStyle.lightThemeDefault);
            break;
          case 1:
            _checkCurrentTheme(ctx, ThemeType.LIGHT_RED, ThemeStyle.lightThemeRed);
            break;
          case 2:
            _checkCurrentTheme(ctx, ThemeType.LIGHT_GREEN, ThemeStyle.lightThemeGreen);
            break;
          case 3:
            DialogUtil.showMyDialog(ctx.context, '注意啦', '切换暗黑主题后需要重启APP才能生效哦~', okText: '修改并重启！', cancelText: '还是不了吧', okAction: () async {
              GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeData(ThemeType.DARK_DEFAULT, ThemeStyle.darkThemeDefault));
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
            break;
        }
      });
      break;
    case '退出登录':
      DialogUtil.showMyDialog(ctx.context, '注意啦', '确定要退出登录吗？？？', okText: '是的！', cancelText: '手滑了~', okAction: () {
        GlobalStore.store.dispatch(GlobalActionCreator.onLogout());
      });
      break;
  }
}