import 'package:hive/hive.dart';

class SplashStatus {
  static const _key = 'splashShown';

  static Future<void> setSplashShown() async {
    final box = await Hive.openBox('settings');
    await box.put(_key, true);
  }

  static Future<bool> getSplashShown() async {
    final box = await Hive.openBox('settings');
    return box.get(_key, defaultValue: false);
  }
}