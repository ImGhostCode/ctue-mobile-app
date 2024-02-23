class ServerException implements Exception {
  final int statusCode;
  final String errorMessage;

  ServerException({required this.statusCode, required this.errorMessage});
}

class CacheException implements Exception {}
