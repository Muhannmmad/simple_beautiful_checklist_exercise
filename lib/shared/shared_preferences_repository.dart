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

  @override
  Future<void> addItem(String item) async {
    if (item.isNotEmpty) {
      final prefs = await _prefs;
      final items = prefs.getStringList(_keyItems) ?? [];
      if (!items.contains(item)) {
        items.add(item);
        await prefs.setStringList(_keyItems, items);
      }
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await _prefs;
    final items = prefs.getStringList(_keyItems) ?? [];
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await prefs.setStringList(_keyItems, items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    if (newItem.isNotEmpty) {
      final prefs = await _prefs;
      final items = prefs.getStringList(_keyItems) ?? [];
      if (index >= 0 && index < items.length && !items.contains(newItem)) {
        items[index] = newItem;
        await prefs.setStringList(_keyItems, items);
      }
    }
  }
}
