import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quote_geh/models/quote.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_quotes';

  Future<List<Quote>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Quote.fromJson(json)).toList();
  }

  Future<void> addFavorite(Quote quote) async {
    final favorites = await getFavorites();
    if (!favorites.any((q) => q.text == quote.text && q.author == quote.author)) {
      favorites.add(quote);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(Quote quote) async {
    final favorites = await getFavorites();
    favorites.removeWhere((q) => q.text == quote.text && q.author == quote.author);
    await _saveFavorites(favorites);
  }

  Future<bool> isFavorite(Quote quote) async {
    final favorites = await getFavorites();
    return favorites.any((q) => q.text == quote.text && q.author == quote.author);
  }

  Future<bool> toggleFavorite(Quote quote) async {
    final isFav = await isFavorite(quote);
    if (isFav) {
      await removeFavorite(quote);
      return false;
    } else {
      await addFavorite(quote);
      return true;
    }
  }

  Future<void> _saveFavorites(List<Quote> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((q) => q.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(jsonList));
  }
}
