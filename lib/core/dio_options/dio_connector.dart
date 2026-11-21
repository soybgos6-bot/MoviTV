import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_2see/core/constants/app_env.dart';
import 'package:movies_2see/core/errors/api_exception.dart';

class DioConnector {
  DioConnector()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppEnv.basePath,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 20),
            headers: <String, dynamic>{
              'accept': 'application/json',
              'Authorization': 'Bearer ${AppEnv.apiKey}',
            },
            queryParameters: <String, dynamic>{'language': 'es-ES'},
          ),
        ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
        ),
      );
    }
  }

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (AppEnv.apiKey.isEmpty || AppEnv.apiKey.startsWith('PEGA_')) {
      throw const ApiException(
        'Falta tu token de TMDB. Pegalo en TMDB_API_KEY dentro del archivo .env y vuelve a ejecutar la app.',
      );
    }
    try {
      return await _dio.get<dynamic>(path, queryParameters: queryParameters);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}

final dioConnectorProvider = Provider<DioConnector>((ref) => DioConnector());
