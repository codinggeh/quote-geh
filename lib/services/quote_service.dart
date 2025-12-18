import 'package:quote_geh/core/constants/api_constants.dart';
import 'package:quote_geh/core/utils/api_helper.dart';
import 'package:quote_geh/models/quote.dart';

class QuoteService {
  final _dio = ApiHelper.dio;

  Future<Quote> getRandomQuote() async {
    final response = await _dio.get(ApiConstants.randomQuote);
    final List<dynamic> data = response.data;
    return Quote.fromJson(data.first);
  }

  Future<Quote> getQuoteOfTheDay() async {
    final response = await _dio.get(ApiConstants.quoteOfTheDay);
    final List<dynamic> data = response.data;
    return Quote.fromJson(data.first);
  }

  Future<List<Quote>> getQuotes() async {
    final response = await _dio.get(ApiConstants.quotes);
    final List<dynamic> data = response.data;
    return data.map((json) => Quote.fromJson(json)).toList();
  }
}
