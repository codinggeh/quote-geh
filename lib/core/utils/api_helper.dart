import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quote_geh/core/constants/api_constants.dart';

class ApiHelper {
  ApiHelper._();

  static Dio? _dio;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static String get baseUrl {
    if (kIsWeb) {
      // Use CORS proxy for web
      return 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(ApiConstants.baseUrl)}';
    }
    return ApiConstants.baseUrl;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: kIsWeb ? '' : ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    return dio;
  }
}

