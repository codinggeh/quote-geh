import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quote_geh/core/constants/api_constants.dart';
import 'package:quote_geh/core/utils/api_helper.dart';
import 'package:quote_geh/models/quote.dart';

class QuoteService {
  final _dio = ApiHelper.dio;

  String _buildUrl(String endpoint) {
    if (kIsWeb) {
      final fullUrl = '${ApiConstants.baseUrl}$endpoint';
      return 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(fullUrl)}';
    }
    return endpoint;
  }

  Future<Quote> getRandomQuote() async {
    final response = await _dio.get(_buildUrl(ApiConstants.randomQuote));
    final List<dynamic> data = response.data;
    return Quote.fromJson(data.first);
  }

  Future<Quote> getQuoteOfTheDay() async {
    final response = await _dio.get(_buildUrl(ApiConstants.quoteOfTheDay));
    final List<dynamic> data = response.data;
    return Quote.fromJson(data.first);
  }

  Future<List<Quote>> getQuotes() async {
    final response = await _dio.get(_buildUrl(ApiConstants.quotes));
    final List<dynamic> data = response.data;
    return data.map((json) => Quote.fromJson(json)).toList();
  }
}

