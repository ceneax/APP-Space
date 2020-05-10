package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import lxiian.plugin.show3d.Show3dPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    Show3dPlugin.registerWith(registry.registrarFor("lxiian.plugin.show3d.Show3dPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
