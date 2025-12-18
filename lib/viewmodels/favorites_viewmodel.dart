import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_geh/models/quote.dart';
import 'package:quote_geh/services/favorites_service.dart';

final favoritesServiceProvider = Provider((ref) => FavoritesService());

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<Quote>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends AsyncNotifier<List<Quote>> {
  @override
  Future<List<Quote>> build() async {
    final service = ref.read(favoritesServiceProvider);
    return service.getFavorites();
  }

  Future<void> toggleFavorite(Quote quote) async {
    final service = ref.read(favoritesServiceProvider);
    await service.toggleFavorite(quote);
    ref.invalidateSelf();
  }

  Future<void> removeFavorite(Quote quote) async {
    final service = ref.read(favoritesServiceProvider);
    await service.removeFavorite(quote);
    ref.invalidateSelf();
  }
}

final isFavoriteProvider = FutureProvider.family<bool, Quote>((ref, quote) async {
  final service = ref.read(favoritesServiceProvider);
  return service.isFavorite(quote);
});
