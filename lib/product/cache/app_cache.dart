import 'package:shared_preferences/shared_preferences.dart';

enum CacheTitles { jwtToken }

class AppCache {
  Future<String?> getCachedValue(CacheTitles title) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = sharedPreferences.getString(title.name);
    print('Cached: $result');
    return result;
  }

  Future<void> saveValue(CacheTitles title, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool succes = await sharedPreferences.setString(title.name, value);
    print('Save: $succes');
  }
}
