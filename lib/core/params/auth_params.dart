class LoginParams {
  final String email;
  final String password;
  final String fcmToken;

  const LoginParams(
      {required this.email, required this.password, required this.fcmToken});
}

class LogoutParams {
  final String accessToken;

  LogoutParams({required this.accessToken});
}

class SignupParams {
  final String name;
  final String email;
  final String password;
  final List<int>? interestTopics;

  const SignupParams(
      {required this.name,
      required this.email,
      required this.password,
      this.interestTopics});
}

class GetUserParams {
  final String accessToken;

  GetUserParams({required this.accessToken});
}
