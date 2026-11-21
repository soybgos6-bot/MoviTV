import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String _get(String key) => dotenv.env[key] ?? '';

  static String get basePath => _get('TMDB_BASE_PATH');

  static String get apiKey => _get('TMDB_API_KEY');

  static String get imgW500 => _get('TMDB_IMG_URL_W500');

  static String get imgOriginal => _get('TMDB_IMG_URL_ORIGINAL');
}
