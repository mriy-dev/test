import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ApiUrlStore {
  ApiUrlStore(this._prefs);

  static const _key = 'api_url';

  final SharedPreferencesAsync _prefs;
  String? _url;

  String? get url => _url;

  Future<void> load() async => _url = await _prefs.getString(_key);

  Future<void> save(String url) async {
    _url = url;
    await _prefs.setString(_key, url);
  }
}
