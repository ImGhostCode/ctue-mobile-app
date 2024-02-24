class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

class SignupParams {
  final String name;
  final String email;
  final String password;

  const SignupParams(
      {required this.name, required this.email, required this.password});
}

class GetUserParams {
  final String accessToken;

  GetUserParams({required this.accessToken});
}
