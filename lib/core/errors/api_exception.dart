import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  factory ApiException.fromDio(DioException error) {
    final type = error.type;

    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout) {
      return const ApiException(
        'La conexion tardo demasiado. Intenta de nuevo.',
      );
    }
    if (type == DioExceptionType.connectionError) {
      return const ApiException('Sin conexion a internet.');
    }
    if (type == DioExceptionType.badResponse) {
      final status = error.response?.statusCode;
      if (status == 401) {
        return const ApiException(
          'Token de TMDB invalido o vencido. Revisa TMDB_API_KEY en el archivo .env',
        );
      }
      if (status == 404) {
        return const ApiException('No se encontro el recurso solicitado (404).');
      }
      return ApiException('El servidor respondio con error ($status).');
    }
    if (type == DioExceptionType.cancel) {
      return const ApiException('La solicitud fue cancelada.');
    }
    return ApiException(
      'Error de red inesperado: ${error.message ?? error.error}',
    );
  }

  @override
  String toString() => message;
}
