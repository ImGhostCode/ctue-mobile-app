import 'package:image_picker/image_picker.dart';

class GetUserParams {
  final String accessToken;

  GetUserParams({required this.accessToken});
}

class UpdateUserParams {
  final int id;
  final XFile? avt;
  final String? name;
  final List<int>? interestTopics;
  final String accessToken;

  UpdateUserParams(
      {required this.id,
      this.avt,
      this.name,
      required this.accessToken,
      this.interestTopics});
}

class ResetPasswordParams {
  final int code;
  final String email;
  final String newPassword;
  final String accessToken;

  ResetPasswordParams(
      {required this.code,
      required this.email,
      required this.newPassword,
      required this.accessToken});
}

class GetAllUserParams {
  final int page;
  final String accessToken;

  GetAllUserParams({required this.page, required this.accessToken});
}

class ToggleBanUserParams {
  final int userId;
  final String accessToken;
  final String? feedback;

  ToggleBanUserParams(
      {required this.userId, required this.accessToken, this.feedback});
}

class DeleteUserParams {
  final int userId;
  final String accessToken;

  DeleteUserParams({required this.userId, required this.accessToken});
}

class GetVerifyCodeParams {
  final String email;

  GetVerifyCodeParams({
    required this.email,
  });
}
