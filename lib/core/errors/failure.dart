abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});

  get accessToken => null;
}

class ServerFailure extends Failure {
  ServerFailure({required int statusCode, required String errorMessage})
      : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}
