import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const _keyItems = 'items';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  @override
  Future<int> get itemCount async {
    final prefs = await _prefs;
    final items = prefs.getStringList(_keyItems) ?? [];
    return items.length;
  }


  @override
  Future<List<String>> getItems() async {
    final prefs = await _prefs;
    return prefs.getStringList(_keyItems) ?? [];
  }


  // Fügt ein neues Item hinzu.
  Future<void> addItem(String item);

  // Löscht ein Item an einem bestimmten Index.
  Future<void> deleteItem(int index);

  // Aktualisiert ein Item an einem bestimmten Index.
  Future<void> editItem(int index, String newItem);
}
}