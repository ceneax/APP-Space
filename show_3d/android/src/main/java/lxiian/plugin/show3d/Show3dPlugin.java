package lxiian.plugin.show3d;

import android.content.Intent;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** Show3dPlugin */
public class Show3dPlugin implements MethodCallHandler {

  private static final String CHANNEL = "lxiian.space/show3d";

  private static Registrar registrar;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    // 先保存Registrar对象
    Show3dPlugin.registrar = registrar;

    final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
    channel.setMethodCallHandler(new Show3dPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("show3dView")) {
      Intent intent = new Intent(registrar.activity(), Show3DActivity.class);
      intent.putExtra("path", call.argument("path").toString());
      registrar.activity().startActivity(intent);
      result.success("success");
    } else {
      result.notImplemented();
    }
  }
}
