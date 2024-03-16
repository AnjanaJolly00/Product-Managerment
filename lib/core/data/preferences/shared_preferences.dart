import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static setbool(key, bool value) {
    _prefsInstance?.setBool(key, value);
  }

  static bool getbool(key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static setString(key, String value) {
    _prefsInstance?.setString(key, value);
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static setInt(key, int value) {
    return _prefsInstance?.setInt(key, value);
  }

  static getInt(key) {
    return _prefsInstance?.getInt(key);
  }

  static setDouble(key, double value) {
    return _prefsInstance?.setDouble(key, value);
  }

  static getDouble(key) {
    return _prefsInstance?.getDouble(key);
  }

  static setList(key, List<String> value) {
    return _prefsInstance?.setStringList(key, value);
  }

  static getList(key) {
    return _prefsInstance?.getStringList(key);
  }

  static remove(String key) {
    return _prefsInstance?.remove(key);
  }

  static clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future setThemeData(String value) {
    return _prefsInstance!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _prefsInstance!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
