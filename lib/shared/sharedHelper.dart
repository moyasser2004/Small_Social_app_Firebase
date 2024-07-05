import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesHelper {

  static SharedPreferences? share;

  static Future<void> init() async {
    share = await SharedPreferences.getInstance();
  }

  static dynamic setUid({
    required String key,
    required String value,
  }) async {
    await share!.setString(key, value);
  }

  static Future<String?> getUid({required String key}) async {
    return share!.getString(key);
  }

}
