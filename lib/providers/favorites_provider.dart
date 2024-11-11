import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void addFavorite(String id) {
    _favorites.add(id);
    notifyListeners();
  }

  void removeFavorite(String id) {
    _favorites.remove(id);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.contains(id);
  }
}