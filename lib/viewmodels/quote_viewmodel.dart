import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_geh/models/quote.dart';
import 'package:quote_geh/services/quote_service.dart';

final quoteServiceProvider = Provider((ref) => QuoteService());

final randomQuoteProvider = FutureProvider.autoDispose<Quote>((ref) async {
  final service = ref.read(quoteServiceProvider);
  return service.getRandomQuote();
});

final quoteOfTheDayProvider = FutureProvider<Quote>((ref) async {
  final service = ref.read(quoteServiceProvider);
  return service.getQuoteOfTheDay();
});

final quotesProvider = FutureProvider<List<Quote>>((ref) async {
  final service = ref.read(quoteServiceProvider);
  return service.getQuotes();
});
